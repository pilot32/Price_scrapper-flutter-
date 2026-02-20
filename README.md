# PRICE TRACKER – MOBILE APPLICATION

---

## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
## PROJECT SUMMARY
## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

A real-time mobile application that enables users to monitor product prices from supported URLs.  
The system automatically checks for price updates and sends push notifications when a price drop is detected.

This project includes:

• Flutter Mobile Application  
• Node.js + Express Backend  
• Firebase Authentication  
• Firestore Database  
• Puppeteer-based Web Scraper  
• Scheduled Background Monitoring  
• Firebase Cloud Messaging (Push Notifications)  

---

## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
## SYSTEM ARCHITECTURE
## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

```
Mobile App (Flutter)
        │
        │  Authenticated Requests
        ▼
Backend (Express + Firebase Admin)
        │
        │  Database Writes
        ▼
Firestore
        │
        │  Scheduled Scraping (Cron)
        ▼
Price Update Detected
        │
        ▼
Push Notification (FCM)
```

---

## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
## CORE FEATURES
## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

### Authentication
----------------------------------------
Secure user registration and login  
Firebase-based identity management  
Token-verified backend requests  

### Product Tracking
----------------------------------------
Add product URL  
Automated price extraction  
Persistent monitoring system  

### Scheduled Monitoring
----------------------------------------
Automated background checks  
Database updates on price change  
Price comparison logic  

### Push Notifications
----------------------------------------
Instant mobile alerts on price drop  
Foreground and background support  
Device token registration  

### Security
----------------------------------------
Backend Firebase ID token validation  
Firestore access restriction  
User data isolation  

---

## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
## TECHNOLOGY STACK
## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

### Mobile Layer
----------------------------------------
Flutter  
Firebase Core  
Firebase Messaging  
HTTP Client  

### Backend Layer
----------------------------------------
Node.js  
Express.js  
Firebase Admin SDK  
Puppeteer  
node-cron  

### Database
----------------------------------------
Cloud Firestore  

### Notifications
----------------------------------------
Firebase Cloud Messaging (FCM)  

---

## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
## PROJECT STRUCTURE
## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

```
mobile_app/
│
├── lib/
├── main.dart
└── pubspec.yaml


backend/
│
├── routes/
├── middleware/
├── index.js
└── firebase/
```

---

## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
## INSTALLATION GUIDE
## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

### 1. Clone Repository

```
git clone <repository-url>
```

---

### 2. Backend Setup

```
cd backend
npm install
```

Add Firebase service account:

```
backend/firebase/serviceAccountKey.json
```

Create `.env` file:

```
PORT=5000
```

Start backend:

```
npm start
```

---

### 3. Mobile Setup

```
cd mobile_app
flutter pub get
```

Add Firebase configuration files:

• google-services.json (Android)  
• GoogleService-Info.plist (iOS if required)  

Run application:

```
flutter run
```

---

## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
## NOTIFICATION FLOW
## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1. User logs in  
2. Device FCM token generated  
3. Token stored in Firestore via backend  
4. Scheduled job checks product prices  
5. If price drops:
   - Firestore updates  
   - Push notification sent  

---

## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
## SECURITY MODEL
## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

• Backend validates all Firebase ID tokens  
• Firestore client access restricted  
• No direct client database writes  
• User-based document separation  

---

## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
## FUTURE ENHANCEMENTS
## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

• Price history tracking  
• Multi-device sync  
• Email alerts  
• Advanced scraping engine  
• Proxy integration  
• Rate limiting  
• Analytics dashboard  

---

## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
## DEVELOPMENT NOTES
## ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

• Scraping logic may require adjustment per website  
• Ensure compliance with website terms  
• Add retry logic for resilience  
• Consider proxy support for production  

---

## LICENSE

This project is intended for educational and development purposes.  
Ensure compliance with applicable laws before public deployment.
