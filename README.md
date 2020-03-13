# Tubles
Tubles is a simple applications to provide any tubles in
    in google maps and we as the user can navigate into the selected tubles location.

## Installing
- git clone https://github.com/yusriltakeuchi/Tubles.git
- flutter packages get
- flutter run

# Billing
You must enable some API in google cloud to use this features
- Google Maps for Android/iOS
- Place API
- Direction API

## Setup
Please fill API KEY with your Google Cloud APIKEY
1. android/app/src/main/AndroidManifest.xml
```xml
<meta-data android:name="com.google.android.geo.API_KEY"
            android:value="<YOUR API KEY>"/>
```

2. ios/Runner/AppDelegate.swift
```swift
GMSServices.provideAPIKey("YOUR API KEY")
```

3. lib/core/viewmodels/maps_provider.dart
```dart
  String _googleAPIKey = "<YOUR API KEY>";
  String get apiKey => _googleAPIKey;
```
