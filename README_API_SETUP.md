# API Key Setup

This app requires a Google Maps API key to function. Follow these steps:

## 1. Get Your API Key

1. Go to [Google Cloud Console](https://console.cloud.google.com/google/maps-apis)
2. Create a new project or select an existing one
3. Enable the following APIs:
   - Maps SDK for Android
   - Maps SDK for iOS
   - Places API
4. Create credentials (API key)

## 2. Restrict Your API Key (Important for Security)

### Android Restrictions
- Application restrictions: Android apps
- Package name: `com.example.health_care`
- SHA-1 certificate fingerprint: Get from your keystore

### iOS Restrictions
- Application restrictions: iOS apps
- Bundle ID: `com.example.healthCare`

## 3. Configure the App

### Android
1. Copy `android/local.properties.example` to `android/local.properties`
2. Replace `YOUR_GOOGLE_MAPS_API_KEY_HERE` with your actual API key
3. The file is gitignored and won't be committed

### iOS
1. Replace `YOUR_API_KEY_HERE` in `ios/Runner/AppDelegate.swift` with your actual key
   OR better: Create a `Keys.plist` file (also gitignored)

### Dart Code
Replace `YOUR_API_KEY_HERE` in `lib/utils/constant.dart` with your actual key

## Security Notes

- **NEVER** commit API keys to version control
- `android/local.properties` is already in `.gitignore`
- Consider using environment variables for CI/CD
- Rotate keys if they are ever exposed
