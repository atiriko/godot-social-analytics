extends Node
## Example: Using Project Settings for Credentials
##
## This example demonstrates how to store TikTok credentials in Project Settings
## instead of hardcoding them. This is the recommended approach for production.

var analytics: SocialAnalytics

func _ready():
	analytics = SocialAnalytics.new()
	
	# Initialize with credentials from Project Settings
	if OS.get_name() == "Android":
		initialize_from_project_settings()

func initialize_from_project_settings():
	"""
	Initialize analytics using credentials stored in Project Settings.
	
	To set these up:
	1. Go to Project → Project Settings → General
	2. Enable "Advanced Settings"
	3. Add custom properties:
	   - analytics/tiktok_app_id (String)
	   - analytics/tiktok_tt_app_id (String)
	   - analytics/tiktok_access_token (String)
	   - analytics/enable_debug (bool)
	"""
	
	# Get credentials from Project Settings
	var app_id = ProjectSettings.get_setting("analytics/tiktok_app_id", "")
	var tt_app_id = ProjectSettings.get_setting("analytics/tiktok_tt_app_id", "")
	var access_token = ProjectSettings.get_setting("analytics/tiktok_access_token", "")
	var enable_debug = ProjectSettings.get_setting("analytics/enable_debug", true)
	
	# Validate credentials
	if app_id.is_empty() or tt_app_id.is_empty() or access_token.is_empty():
		push_error("Analytics credentials not configured in Project Settings!")
		return
	
	# Initialize TikTok
	analytics.init_tiktok(app_id, tt_app_id, access_token, enable_debug)
	print("Analytics initialized from Project Settings")

## Alternative: Add these settings programmatically (run once)
func setup_project_settings():
	"""
	Call this once to set up the Project Settings entries.
	After running, you can edit them in the Project Settings UI.
	"""
	
	if not ProjectSettings.has_setting("analytics/tiktok_app_id"):
		ProjectSettings.set_setting("analytics/tiktok_app_id", "com.yourcompany.yourgame")
		ProjectSettings.set_initial_value("analytics/tiktok_app_id", "com.yourcompany.yourgame")
	
	if not ProjectSettings.has_setting("analytics/tiktok_tt_app_id"):
		ProjectSettings.set_setting("analytics/tiktok_tt_app_id", "")
		ProjectSettings.set_initial_value("analytics/tiktok_tt_app_id", "")
	
	if not ProjectSettings.has_setting("analytics/tiktok_access_token"):
		ProjectSettings.set_setting("analytics/tiktok_access_token", "")
		ProjectSettings.set_initial_value("analytics/tiktok_access_token", "")
	
	if not ProjectSettings.has_setting("analytics/enable_debug"):
		ProjectSettings.set_setting("analytics/enable_debug", true)
		ProjectSettings.set_initial_value("analytics/enable_debug", true)
	
	# Save the settings
	ProjectSettings.save()
	print("Project Settings configured for analytics")
