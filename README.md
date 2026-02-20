Price Tracker – Mobile Application

A real-time mobile application that allows users to track product prices from supported e-commerce URLs. The system monitors price changes automatically and sends push notifications when a price drop is detected.

Overview

This project consists of:

Flutter Mobile Application

Node.js + Express Backend

Firebase Authentication

Firestore Database

Automated Web Scraper (Puppeteer)

Scheduled Price Monitoring (Cron Job)

Firebase Cloud Messaging (Push Notifications)

The app enables users to:

Register and authenticate securely

Add product URLs for tracking

View tracked products

Receive push notifications on price drops

Monitor automatic background updates

Architecture
Mobile App (Flutter)
        |
        |  Authenticated API Calls
        v
Backend (Express + Firebase Admin)
        |
        |  Writes / Updates
        v
Firestore Database
        |
        |  Scheduled Scraping
        v
Price Updates -> Push Notification (FCM)

Features
Authentication

Secure login and signup

Firebase Authentication integration

Token-based backend verification

Product Tracking

Add product URL

Automatic price extraction

Persistent product monitoring

Real-Time Updates

Scheduled backend price checks

Firestore updates on price change

Optional live UI updates

Push Notifications

Mobile push notifications on price drop

Works in foreground, background, and terminated states

Security

Backend verifies Firebase ID tokens

Firestore rules restrict unauthorized access

No direct client database writes

Tech Stack
Mobile

Flutter

Firebase Core

Firebase Messaging

HTTP Client

Backend

Node.js

Express.js

Firebase Admin SDK

Puppeteer (Web Scraping)

node-cron (Scheduled Tasks)

Database

Cloud Firestore

Notifications

Firebase Cloud Messaging (FCM)

Project Structure
mobile_app/
    lib/
    main.dart
    pubspec.yaml

backend/
    routes/
    middleware/
    index.js
    firebase/

Setup Instructions
1. Clone Repository
git clone <repository-url>

2. Backend Setup
cd backend
npm install


Add Firebase service account file:

backend/firebase/serviceAccountKey.json


Create .env file:

PORT=5000


Run server:

npm start

3. Mobile Setup
cd mobile_app
flutter pub get


Add configuration files:

google-services.json for Android

GoogleService-Info.plist for iOS (if applicable)

Run application:

flutter run

How Notifications Work

User logs in

App generates FCM device token

Token is stored in Firestore via backend

Scheduled job checks product prices

On price drop:

Firestore updated

FCM notification sent to user device

Security Design

Backend validates all requests using Firebase ID tokens

Firestore client access is restricted

Only authenticated users can track products

User data is isolated per account

Future Improvements

Price history visualization

Multi-product tracking dashboard

Email alerts

Web dashboard

Advanced scraping engine

Proxy integration

Rate limiting

Admin panel

Development Notes

Scraping logic may require adjustment for different websites

Ensure compliance with applicable laws and website policies

Configure retry logic for failed scrapes

Use proxies in production for scraping stability
License

This project is intended for educational and development purposes.
Ensure compliance with applicable laws and platform policies before deploying publicly.
