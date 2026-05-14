# המבוך הקסום - גרסה רשמית

זו גרסת הפצה סטטית וקלה של המשחק הרשמי, עם מנוע המחשב המעודכן מגרסה 40. היא לא כוללת את גרסת הדיבאג, לא כוללת מצב מחשב מול מחשב, ולא מציגה עומק חיפוש או מספר מצבים שנבדקו.

## הרצה מקומית במחשב

1. פתח PowerShell בתיקייה:

```powershell
cd D:\Erez\code\Maze\official-game
```

2. הרץ:

```powershell
.\Run-Official-Game.bat
```

3. פתח בדפדפן במחשב את הכתובת שהחלון מציג. בדרך כלל:

```text
http://localhost:4173
```

אם הפורט 4173 תפוס, הקובץ יבחר פורט פנוי אחר ויציג אותו בחלון.

## בדיקה באייפון או אייפד לפני העלאה

1. ודא שהמחשב והאייפון/אייפד מחוברים לאותה רשת Wi-Fi.
2. הרץ במחשב את `Run-Official-Game.bat`.
3. מצא את כתובת ה-IP של המחשב:

```powershell
ipconfig
```

חפש את `IPv4 Address` תחת מתאם ה-Wi-Fi. זה ייראה למשל כך:

```text
192.168.1.23
```

4. באייפון או באייפד פתח Safari וגלוש אל הכתובת שהחלון מציג תחת `iPhone/iPad on the same Wi-Fi`. לדוגמה:

```text
http://192.168.1.23:4173
```

החלף את הכתובת בדוגמה בכתובת ה-IP האמיתית של המחשב שלך. אם Windows מציג בקשת Firewall, אשר גישה לרשת הפרטית.

## העלאה ל-GitHub

מומלץ ליצור repository נפרד לגרסה הרשמית, ולהעלות אליו את תוכן התיקייה `official-game` בלבד.

```powershell
cd D:\Erez\code\Maze\official-game
git init
git add .
git commit -m "Official game release"
git branch -M main
git remote add origin https://github.com/YOUR_USER/YOUR_REPO.git
git push -u origin main
```

החלף את `YOUR_USER/YOUR_REPO` בשם המשתמש וה-repository שלך.

## העלאה ל-Cloudflare Pages

אפשרות GitHub:

1. היכנס ל-Cloudflare Pages.
2. בחר `Create a project`.
3. חבר את ה-repository הרשמי שיצרת ב-GitHub.
4. הגדר:
   - Framework preset: `None`
   - Build command: ריק
   - Build output directory: `.`
5. פרסם.

אפשרות Direct Upload:

1. היכנס ל-Cloudflare Pages.
2. בחר יצירת פרויקט עם Direct Upload.
3. גרור/העלה את תוכן התיקייה `official-game`.

## הערה חשובה

אל תמחק את התיקייה הראשית של הפרויקט. גרסת הדיבאג והפיתוח נשארת בתיקייה הראשית, והגרסה הרשמית נמצאת רק בתוך `official-game`.
