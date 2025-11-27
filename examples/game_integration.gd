extends Node
## Example: Complete Game Integration
##
## This example shows a complete game integration with analytics tracking
## for common game events like level progression, achievements, and purchases.

var analytics: SocialAnalytics
var current_level: int = 1
var session_start_time: float = 0.0

func _ready():
	analytics = SocialAnalytics.new()
	session_start_time = Time.get_ticks_msec() / 1000.0
	
	if OS.get_name() == "Android":
		# Initialize from Project Settings
		var app_id = ProjectSettings.get_setting("analytics/tiktok_app_id", "")
		var tt_app_id = ProjectSettings.get_setting("analytics/tiktok_tt_app_id", "")
		var token = ProjectSettings.get_setting("analytics/tiktok_access_token", "")
		
		if not app_id.is_empty():
			analytics.init_tiktok(app_id, tt_app_id, token, true)
			track_session_start()

## Session Tracking
func track_session_start():
	"""Track when a game session starts"""
	analytics.log_firebase_event("session_start", {
		"timestamp": Time.get_unix_time_from_system()
	})
	analytics.log_event("session_start", {})

func track_session_end():
	"""Track when a game session ends"""
	var session_duration = (Time.get_ticks_msec() / 1000.0) - session_start_time
	
	analytics.log_firebase_event("session_end", {
		"duration": session_duration
	})
	analytics.log_event("session_end", {
		"duration": session_duration
	})

## Level Tracking
func on_level_start(level: int, difficulty: String = "normal"):
	"""Called when player starts a level"""
	current_level = level
	
	analytics.log_firebase_event("level_start", {
		"level_num": level,
		"difficulty": difficulty
	})
	analytics.log_event("level_start", {
		"level": level,
		"difficulty": difficulty
	})

func on_level_complete(score: int, stars: int, time_seconds: float):
	"""Called when player completes a level"""
	analytics.log_firebase_event("level_complete", {
		"level_num": current_level,
		"score": score,
		"stars": stars,
		"time": time_seconds,
		"success": true
	})
	
	analytics.log_event("level_complete", {
		"level": current_level,
		"score": score,
		"stars": stars
	})

func on_level_failed(reason: String):
	"""Called when player fails a level"""
	analytics.log_firebase_event("level_fail", {
		"level_num": current_level,
		"reason": reason
	})
	
	analytics.log_event("level_fail", {
		"level": current_level,
		"reason": reason
	})

## Achievement Tracking
func unlock_achievement(achievement_id: String, achievement_name: String):
	"""Track when player unlocks an achievement"""
	analytics.log_firebase_event("unlock_achievement", {
		"achievement_id": achievement_id,
		"achievement_name": achievement_name
	})
	
	analytics.log_event("achievement_unlocked", {
		"achievement_id": achievement_id
	})

## Purchase Tracking
func on_purchase_started(item_id: String, price: float):
	"""Called when player initiates a purchase"""
	analytics.log_event("initiate_checkout", {
		"item_id": item_id,
		"value": price,
		"currency": "USD"
	})

func on_purchase_complete(item_id: String, item_name: String, price: float, currency: String = "USD"):
	"""Called when purchase is completed"""
	analytics.log_firebase_event("purchase", {
		"item_id": item_id,
		"item_name": item_name,
		"value": price,
		"currency": currency,
		"timestamp": Time.get_unix_time_from_system()
	})
	
	analytics.log_event("purchase", {
		"item_id": item_id,
		"value": price,
		"currency": currency
	})

## Ad Tracking
func on_ad_shown(ad_id: String, ad_network: String, placement: String):
	"""Track ad impressions"""
	analytics.log_firebase_event("ad_impression", {
		"ad_network": ad_network,
		"ad_unit_id": ad_id,
		"placement": placement
	})
	
	analytics.log_event("ad_impression", {
		"ad_id": ad_id,
		"placement": placement
	})

func on_ad_clicked(ad_id: String, placement: String):
	"""Track ad clicks"""
	analytics.log_event("ad_click", {
		"ad_id": ad_id,
		"placement": placement
	})

func on_rewarded_ad_watched(reward_type: String, reward_amount: int):
	"""Track rewarded ad completion"""
	analytics.log_firebase_event("rewarded_ad_watched", {
		"reward_type": reward_type,
		"reward_amount": reward_amount
	})

## User Progression
func on_tutorial_begin():
	"""Track tutorial start"""
	analytics.log_firebase_event("tutorial_begin", {})
	analytics.log_event("tutorial_begin", {})

func on_tutorial_complete():
	"""Track tutorial completion"""
	analytics.log_firebase_event("tutorial_complete", {})
	analytics.log_event("tutorial_complete", {})

func on_character_selected(character_name: String):
	"""Track character selection"""
	analytics.log_firebase_event("character_select", {
		"character": character_name
	})

## Custom Events
func track_boss_defeated(boss_name: String, attempts: int):
	"""Track boss battles"""
	analytics.log_firebase_event("boss_defeated", {
		"boss_name": boss_name,
		"attempts": attempts,
		"level": current_level
	})

func track_player_death(cause: String):
	"""Track player deaths"""
	analytics.log_firebase_event("player_death", {
		"cause": cause,
		"level": current_level
	})

func track_settings_changed(setting: String, value):
	"""Track when player changes settings"""
	analytics.log_firebase_event("settings_changed", {
		"setting": setting,
		"value": str(value)
	})

## Cleanup
func _exit_tree():
	"""Track session end when game closes"""
	track_session_end()
