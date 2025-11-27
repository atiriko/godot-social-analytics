# SocialAnalytics Plugin for Godot 4.x

[![Godot Version](https://img.shields.io/badge/Godot-4.x-blue.svg)](https://godotengine.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A powerful analytics plugin for Godot 4.x that provides seamless integration with **Firebase Analytics** and **TikTok Events** for Android games.

## ✨ Features

- 🔥 **Firebase Analytics** - Track user behavior, custom events, and player metrics
- 🎵 **TikTok Events** - Monitor ad performance and user acquisition from TikTok campaigns
- 📊 **Unified API** - Simple GDScript interface for all analytics platforms
- 🔧 **Easy Configuration** - No source code modifications required
- 📱 **Android Support** - Optimized for Android deployment

## 📋 Requirements

- Godot 4.x
- Android export template
- Firebase project (for Firebase Analytics)
- TikTok Events Manager account (for TikTok tracking)

## 🚀 Installation

### Step 1: Add the Plugin to Your Godot Project

1. **Download the plugin**
   - Download or clone this repository
   - Locate the `addons/SocialAnalytics` folder

2. **Copy to your project**
   ```bash
   # If you cloned the repo
   cp -r /path/to/godot-social-analytics/addons/SocialAnalytics /path/to/your-project/addons/
   
   # Or manually: Copy the entire SocialAnalytics folder into your project's addons/ directory
   # Your structure should look like:
   # your-project/
   # ├── addons/
   # │   └── SocialAnalytics/
   # │       ├── README.md
   # │       ├── plugin.cfg
   # │       ├── social_analytics_interface.gd
   # │       └── ...
   ```

3. **Enable the plugin in Godot**
   - Open your project in Godot Editor
   - Go to **Project → Project Settings → Plugins**
   - Find **SocialAnalytics** in the list
   - Check the "Enable" checkbox
   - You should see "Active" status

### Step 2: Configure Firebase Analytics

#### 2.1. Get google-services.json

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project (or create a new one)
3. Click the Android icon to add an Android app
4. Enter your package name (e.g., `com.yourcompany.yourgame`)
5. Download the `google-services.json` file

#### 2.2. Add google-services.json to Your Project

The file must be placed in your Godot project's Android build directory:

```bash
# Create the android/build directory if it doesn't exist
mkdir -p android/build

# Copy google-services.json
cp /path/to/google-services.json android/build/google-services.json
```

**Final structure:**
```
your-project/
├── android/
│   └── build/
│       ├── google-services.json    ← Place here
│       ├── build.gradle           ← Configure this (next step)
│       └── AndroidManifest.xml
```

#### 2.3. Configure build.gradle

Your `android/build/build.gradle` needs Firebase dependencies. Add these:

**At the top (buildscript section):**
```gradle
buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath 'com.google.gms:google-services:4.3.15'
        classpath 'com.google.firebase:firebase-crashlytics-gradle:2.9.5'
    }
}
```

**In the dependencies section:**
```gradle
dependencies {
    // ... other dependencies ...
    
    implementation platform("com.google.firebase:firebase-bom:32.3.1")
    implementation "com.google.firebase:firebase-analytics"
    implementation "com.google.firebase:firebase-installations"
}
```

**At the bottom of the file:**
```gradle
apply plugin: 'com.google.gms.google-services'
```

#### 2.4. Enable Firebase in AndroidManifest.xml

In `android/build/AndroidManifest.xml`, ensure Firebase is enabled:

```xml
<application>
    <!-- Change false to true to enable Firebase Analytics -->
    <meta-data 
        android:name="firebase_analytics_collection_enabled" 
        android:value="true" />
</application>
```

### Step 3: Get TikTok Credentials

1. Go to [TikTok Events Manager](https://ads.tiktok.com/marketing_api/apps)
2. Create a new app or select an existing one
3. Note these three values:
   - **App ID**: Your Android package name (e.g., `com.yourcompany.yourgame`)
   - **TT App ID**: A numeric ID from TikTok (e.g., `1234567890`)
   - **Access Token**: A long string token from TikTok

> **⚠️ Important**: Never commit these credentials to version control! Use Project Settings or environment variables (see Configuration section below).

## 📖 Quick Start

### Basic Usage

```gdscript
extends Node

var analytics: SocialAnalytics

func _ready():
    # Initialize the analytics plugin
    analytics = SocialAnalytics.new()
    
    # Initialize TikTok with your credentials
    analytics.init_tiktok(
        "com.yourcompany.yourgame",  # Your Android package name
        "1234567890",                 # Your TikTok App ID
        "your_access_token_here",     # Your TikTok Access Token
        true                          # Enable debug mode
    )
    
    # Log a Firebase event
    analytics.log_firebase_event("game_start", {
        "level": 1,
        "character": "warrior"
    })
    
    # Log a TikTok event
    analytics.log_event("level_complete", {
        "level": 1,
        "score": 1500
    })
```

### Complete Example

```gdscript
extends Node

var analytics: SocialAnalytics

func _ready():
    analytics = SocialAnalytics.new()
    
    # Initialize TikTok
    if OS.get_name() == "Android":
        analytics.init_tiktok(
            ProjectSettings.get_setting("application/config/name"),
            "YOUR_TIKTOK_APP_ID",
            "YOUR_ACCESS_TOKEN"
        )
    
    # Track app launch
    track_app_launch()

func track_app_launch():
    analytics.log_firebase_event("first_open", {"opened": 1})

func track_purchase(item_name: String, price: float):
    var params = {
        "item_name": item_name,
        "price": price,
        "currency": "USD"
    }
    analytics.log_firebase_event("purchase", params)
    analytics.log_event("purchase", params)

func track_level_complete(level: int, score: int):
    var params = {
        "level": level,
        "score": score,
        "time_spent": 120
    }
    analytics.log_firebase_event("level_complete", params)
    analytics.log_event("level_complete", params)
```

## 📚 API Reference

### `init_tiktok(app_id, tt_app_id, access_token, enable_debug)`

Initialize the TikTok SDK with your credentials.

**Parameters:**
- `app_id` (String): Your Android app package name
- `tt_app_id` (String): Your TikTok App ID from TikTok Events Manager
- `access_token` (String): Your TikTok Access Token
- `enable_debug` (bool, optional): Enable debug logging (default: `true`)

**Example:**
```gdscript
analytics.init_tiktok("com.example.game", "1234567890", "token123", true)
```

### `log_firebase_event(event_name, params)`

Log an event to Firebase Analytics.

**Parameters:**
- `event_name` (String): Name of the event
- `params` (Dictionary, optional): Event parameters

**Example:**
```gdscript
analytics.log_firebase_event("level_start", {"level": 1, "character": "mage"})
```

### `log_event(event_name, params)`

Log an event to TikTok Analytics.

**Parameters:**
- `event_name` (String): Name of the event
- `params` (Dictionary, optional): Event parameters

**Example:**
```gdscript
analytics.log_event("ad_click", {"ad_id": "12345", "placement": "main_menu"})
```

## 🔧 Configuration

### Storing Credentials Securely

**Never hardcode credentials in your source code!** Use one of these methods:

#### Option 1: Project Settings
```gdscript
# Add to Project Settings
ProjectSettings.set_setting("analytics/tiktok_app_id", "YOUR_APP_ID")
ProjectSettings.set_setting("analytics/tiktok_tt_app_id", "YOUR_TT_APP_ID")
ProjectSettings.set_setting("analytics/tiktok_access_token", "YOUR_TOKEN")

# Use in code
analytics.init_tiktok(
    get_package_name(),
    ProjectSettings.get_setting("analytics/tiktok_tt_app_id"),
    ProjectSettings.get_setting("analytics/tiktok_access_token")
)
```

#### Option 2: Environment Variables
```gdscript
analytics.init_tiktok(
    get_package_name(),
    OS.get_environment("TIKTOK_APP_ID"),
    OS.get_environment("TIKTOK_ACCESS_TOKEN")
)
```

#### Option 3: Configuration File
Create a `config.json` (add to `.gitignore`):
```json
{
    "tiktok_app_id": "YOUR_APP_ID",
    "tiktok_tt_app_id": "YOUR_TT_APP_ID",
    "tiktok_access_token": "YOUR_TOKEN"
}
```

## 🐛 Troubleshooting

### Firebase Events Not Appearing

1. **Enable DebugView**: Run this ADB command:
   ```bash
   adb shell setprop debug.firebase.analytics.app YOUR_PACKAGE_NAME
   ```

2. **Check Logcat**: Look for Firebase-related messages
   ```bash
   adb logcat | grep -i firebase
   ```

3. **Wait 24 hours**: Standard Firebase events can take up to 24 hours to appear

### TikTok Events Not Tracking

1. **Enable Debug Mode**: Set `enable_debug = true` in `init_tiktok()`
2. **Check Credentials**: Verify your App ID and Access Token are correct
3. **Check Logcat**: Look for TikTok SDK messages

## 🤝 Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Built for the Godot Engine community
- Uses Firebase Analytics SDK
- Uses TikTok Business SDK

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/yourusername/godot-social-analytics/issues)
- **Discussions**: [GitHub Discussions](https://github.com/yourusername/godot-social-analytics/discussions)
- **Discord**: [Join our Discord](#)

## 🗺️ Roadmap

- [ ] iOS support
- [ ] Facebook Analytics integration
- [ ] Custom event validation
- [ ] Event batching and optimization
- [ ] Web export support

---

**Made with ❤️ for Godot developers**
