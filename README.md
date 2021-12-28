# Tubles
Tubles is a simple applications to provide any tubles place
    in google maps and we as the user can navigate into the selected tubles location.

<p>
<img  src="https://i.ibb.co/MhxgsDL/Screenshot-2020-05-24-23-22-57-390-com-yurani-tubles.jpg"  width=265/>
<img  src="https://i.ibb.co/HVc3wxm/Screenshot-2020-05-24-22-05-22-593-com-yurani-tubles.jpg"  width=265/>
<img  src="https://i.ibb.co/rGyDxwK/Screenshot-2020-05-23-15-42-49-418-com-yurani-tubles.jpg"  width=265/>
</p>

## Features
- Display Tubles Location
- Custom Beauty Marker
- Navigation Mode & Normal Mode
- Direction Route to Tubles
- Distance Calculations
- Location Subscribtion Listener
- Custom Map Style Terrain

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

# CHANGELOG
v1.0.3
- Fix Deprecated Embedding Android v2
- Migrating to Null Safety
- Change Location to Geolocator
- Updating GoogleMapPolyline Package

v1.0.2
- Adding Search Tubles
- Refactoring Code
- Fixing Camera Zoom & Bearing

v1.0.1
- Adding Custom Marker
- Distance Calculations
- Animation Item Slide

v1.0.0
- First Release

## Contributors

<a href="https://github.com/yusriltakeuchi/tubles/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=yusriltakeuchi/tubles" />
</a>
