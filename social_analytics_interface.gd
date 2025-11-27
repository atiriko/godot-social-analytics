## SocialAnalytics
##
## Firebase and TikTok Analytics integration for Godot 4.x
## Provides methods to log analytics events to Firebase and TikTok platforms.
##
class_name SocialAnalytics extends Object

var _plugin_singleton

func _init():
	if Engine.has_singleton("SocialAnalytics"):
		_plugin_singleton = Engine.get_singleton("SocialAnalytics")
	else:
		printerr("SocialAnalytics singleton not found! Make sure the plugin is enabled and running on Android.")

## Initialize TikTok SDK with your credentials
## 
## @param app_id: Your Android app package name (e.g., "com.yourcompany.yourgame")
## @param tt_app_id: Your TikTok App ID from TikTok Events Manager
## @param access_token: Your TikTok Access Token from TikTok Events Manager
## @param enable_debug: Enable debug logging (default: true)
func init_tiktok(app_id: String, tt_app_id: String, access_token: String, enable_debug: bool = true) -> void:
	if _plugin_singleton:
		_plugin_singleton.initTikTok(app_id, tt_app_id, access_token, enable_debug)
	else:
		printerr("SocialAnalytics: Cannot init TikTok, singleton missing.")

## Log an event to TikTok Analytics
##
## @param event_name: Name of the event (e.g., "level_complete", "purchase")
## @param params: Dictionary of event parameters (optional)
func log_event(event_name: String, params: Dictionary = {}) -> void:
	if _plugin_singleton:
		_plugin_singleton.logEvent(event_name, params)
	else:
		printerr("SocialAnalytics: Cannot log event, singleton missing.")

## Log an event to Firebase Analytics
##
## @param event_name: Name of the event (e.g., "first_open", "level_start")
## @param params: Dictionary of event parameters (optional)
func log_firebase_event(event_name: String, params: Dictionary = {}) -> void:
	if _plugin_singleton:
		_plugin_singleton.logFirebaseEvent(event_name, params)
	else:
		printerr("SocialAnalytics: Cannot log Firebase event, singleton missing.")
