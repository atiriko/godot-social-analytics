extends Node
## Example: Basic Analytics Integration
##
## This example shows how to initialize and use SocialAnalytics plugin
## for Firebase and TikTok event tracking.

var analytics: SocialAnalytics

# Your TikTok credentials - DO NOT hardcode in production!
# Use Project Settings, environment variables, or a config file
const TIKTOK_APP_ID = "com.yourcompany.yourgame" # Your Android package name
const TIKTOK_TT_APP_ID = "YOUR_TIKTOK_APP_ID" # From TikTok Events Manager
const TIKTOK_ACCESS_TOKEN = "YOUR_ACCESS_TOKEN" # From TikTok Events Manager

func _ready():
	# Initialize the analytics plugin
	analytics = SocialAnalytics.new()
	
	# Only initialize on Android
	if OS.get_name() == "Android":
		initialize_analytics()
		
		# Track app startup
		track_app_start()

func initialize_analytics():
	"""Initialize TikTok SDK with your credentials"""
	analytics.init_tiktok(
		TIKTOK_APP_ID,
		TIKTOK_TT_APP_ID,
		TIKTOK_ACCESS_TOKEN,
		true # Enable debug mode
	)
	print("Analytics initialized")

func track_app_start():
	"""Track when the app starts"""
	# Firebase event
	analytics.log_firebase_event("app_start", {
		"timestamp": Time.get_unix_time_from_system()
	})
	
	# TikTok event
	analytics.log_event("app_open", {
		"source": "direct_launch"
	})

func track_user_login(user_id: String):
	"""Track when a user logs in"""
	analytics.log_firebase_event("login", {
		"user_id": user_id,
		"method": "email"
	})

func track_level_start(level: int):
	"""Track when a player starts a level"""
	analytics.log_firebase_event("level_start", {
		"level_num": level,
		"character": "hero"
	})
	
	analytics.log_event("level_start", {
		"level": level
	})

func track_level_complete(level: int, score: int, time_seconds: float):
	"""Track when a player completes a level"""
	var params = {
		"level": level,
		"score": score,
		"time": time_seconds,
		"success": true
	}
	
	# Log to both platforms
	analytics.log_firebase_event("level_complete", params)
	analytics.log_event("level_complete", params)

func track_purchase(item_name: String, price: float, currency: String = "USD"):
	"""Track in-app purchases"""
	var params = {
		"item_name": item_name,
		"value": price,
		"currency": currency,
		"timestamp": Time.get_unix_time_from_system()
	}
	
	analytics.log_firebase_event("purchase", params)
	analytics.log_event("purchase", params)

func track_ad_impression(ad_id: String, placement: String):
	"""Track ad impressions"""
	analytics.log_event("ad_impression", {
		"ad_id": ad_id,
		"placement": placement
	})

func track_custom_event(event_name: String, params: Dictionary = {}):
	"""Track any custom event"""
	analytics.log_firebase_event(event_name, params)
	analytics.log_event(event_name, params)
