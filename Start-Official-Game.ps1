$ErrorActionPreference = 'Stop'

Set-Location -LiteralPath $PSScriptRoot

function Test-PortFree {
  param([int]$Port)

  $listener = [System.Net.Sockets.TcpListener]::new([System.Net.IPAddress]::Loopback, $Port)
  try {
    $listener.Start()
    return $true
  } catch {
    return $false
  } finally {
    try { $listener.Stop() } catch {}
  }
}

function Find-FreePort {
  param(
    [int]$StartPort = 4173,
    [int]$EndPort = 4199
  )

  for ($port = $StartPort; $port -le $EndPort; $port++) {
    if (Test-PortFree -Port $port) {
      return $port
    }
  }

  throw "No free port was found between $StartPort and $EndPort."
}

function Get-WorkingPython {
  $names = @('python', 'py')

  foreach ($name in $names) {
    $commands = @(Get-Command $name -ErrorAction SilentlyContinue)
    foreach ($command in $commands) {
      if (-not $command.Source) {
        continue
      }
      if ($command.Source -like '*\WindowsApps\python.exe') {
        continue
      }

      $version = & $command.Source --version 2>&1
      if ($LASTEXITCODE -eq 0 -and "$version" -match 'Python') {
        return $command.Source
      }
    }
  }

  return $null
}

function Get-LanAddresses {
  try {
    return @(Get-NetIPAddress -AddressFamily IPv4 |
      Where-Object {
        $_.IPAddress -notlike '127.*' -and
        $_.IPAddress -notlike '169.254.*' -and
        $_.PrefixOrigin -ne 'WellKnown'
      } |
      Select-Object -ExpandProperty IPAddress -Unique)
  } catch {
    return @()
  }
}

$port = Find-FreePort
$python = Get-WorkingPython

Write-Host ''
Write-Host 'Official game server'
Write-Host '--------------------'
Write-Host "Folder: $PSScriptRoot"
Write-Host "Computer: http://localhost:$port"

$lanAddresses = Get-LanAddresses
if ($lanAddresses.Count -gt 0) {
  Write-Host ''
  Write-Host 'iPhone/iPad on the same Wi-Fi:'
  foreach ($ip in $lanAddresses) {
    Write-Host "  http://$ip`:$port"
  }
} else {
  Write-Host ''
  Write-Host 'Could not detect a LAN IP automatically. Run ipconfig and use your IPv4 address.'
}

Write-Host ''
Write-Host 'Leave this window open while playing.'
Write-Host 'Press Ctrl+C to stop the server.'
Write-Host ''

if ($python) {
  & $python -m http.server $port --bind 0.0.0.0
  exit $LASTEXITCODE
}

$npx = Get-Command npx.cmd -ErrorAction SilentlyContinue
if (-not $npx) {
  $npx = Get-Command npx -ErrorAction SilentlyContinue
}

if ($npx -and $npx.Source) {
  & $npx.Source --yes serve . -l "tcp://0.0.0.0:$port"
  exit $LASTEXITCODE
}

throw 'Could not find Python or npx. Install Python or Node.js, then run this launcher again.'
