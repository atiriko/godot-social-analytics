# SocialAnalytics Quick Reference

## Setup Steps

### 1. Install Plugin
```bash
# Copy to your project
cp -r addons/SocialAnalytics your-project/addons/

# Enable in Godot:
# Project → Project Settings → Plugins → Enable SocialAnalytics
```

### 2. Configure Firebase
```bash
# Create android build directory
mkdir -p android/build

# Copy google-services.json to android/build/
cp google-services.json android/build/
```

**Update `android/build/build.gradle`:**
```gradle
buildscript {
    dependencies {
        classpath 'com.google.gms:google-services:4.3.15'
    }
}

dependencies {
    implementation platform("com.google.firebase:firebase-bom:32.3.1")
    implementation "com.google.firebase:firebase-analytics"
    implementation "com.google.firebase:firebase-installations"
}

// At bottom of file:
apply plugin: 'com.google.gms.google-services'
```

**Enable in `android/build/AndroidManifest.xml`:**
```xml
<meta-data 
    android:name="firebase_analytics_collection_enabled" 
    android:value="true" />
```

## Initialization

```gdscript
var analytics = SocialAnalytics.new()

# Initialize TikTok (Android only)
analytics.init_tiktok(
    "com.yourcompany.game",  # App ID (package name)
    "1234567890",             # TT App ID
    "your_token",             # Access Token
    true                      # Debug mode
)
```

## Common Events

### Firebase
```gdscript
# App events
analytics.log_firebase_event("session_start", {})
analytics.log_firebase_event("first_open", {"opened": 1})

# Game events
analytics.log_firebase_event("level_start", {"level": 1})
analytics.log_firebase_event("level_complete", {
    "level": 1,
    "score": 1000,
    "time": 45.5
})

# Purchases
analytics.log_firebase_event("purchase", {
    "item": "gold_pack",
    "value": 4.99,
    "currency": "USD"
})
```

### TikTok
```gdscript
# Track generic events
analytics.log_event("app_open", {})
analytics.log_event("level_complete", {"level": 1})
analytics.log_event("purchase", {"value": 4.99})

# Ad events
analytics.log_event("ad_impression", {
    "ad_id": "banner_01",
    "placement": "main_menu"
})
```

## Secure Credential Storage

### Option 1: Project Settings
```gdscript
# Set once
ProjectSettings.set_setting("analytics/tiktok_tt_app_id", "1234567890")
ProjectSettings.save()

# Use
var app_id = ProjectSettings.get_setting("analytics/tiktok_tt_app_id")
analytics.init_tiktok(get_package_name(), app_id, token)
```

### Option 2: Environment Variables
```gdscript
analytics.init_tiktok(
    get_package_name(),
    OS.get_environment("TIKTOK_APP_ID"),
    OS.get_environment("TIKTOK_TOKEN")
)
```

## Firebase DebugView

Enable real-time event viewing:
```bash
adb shell setprop debug.firebase.analytics.app YOUR_PACKAGE_NAME
```

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Events not appearing | Wait 24hrs or enable DebugView |
| Singleton not found | Enable plugin in Project Settings |
| TikTok init failed | Check credentials and logcat |
| Build errors | Ensure google-services.json is in android/build/ |

## File Structure
```
addons/SocialAnalytics/
├── README.md              # Full documentation
├── LICENSE                # MIT License
├── CHANGELOG.md           # Version history
├── CONTRIBUTING.md        # Contribution guide
├── .gitignore            # Git ignore rules
├── plugin.cfg            # Plugin metadata
├── social_analytics_interface.gd  # API
├── social_analytics_export_plugin.gd
├── bin/                  # Compiled binaries
└── examples/             # Usage examples
    ├── basic_usage.gd
    ├── project_settings_usage.gd
    └── game_integration.gd
```

## Links

- [Full README](README.md)
- [API Reference](README.md#-api-reference)
- [Examples](examples/)
- [Contributing](CONTRIBUTING.md)
