# Tubles
Tubles is a simple applications to provide any tubles place
    in google maps and we as the user can navigate into the selected tubles location.

<p>
<img  src="https://i.ibb.co/v4yNgjc/Screenshot-2020-05-23-15-48-14-357-com-yurani-tubles.jpg"  width=265/>
<img  src="https://i.ibb.co/rGyDxwK/Screenshot-2020-05-23-15-42-49-418-com-yurani-tubles.jpg"  width=265/>
</p>

## Features
- Display Tubles Location
- Custom Beauty Marker
- Navigation Mode & Normal Mode
- Direction Route to Tubles
- Distance Calculations
- Location Subscribtion Listener

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
