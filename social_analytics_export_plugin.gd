@tool
extends EditorPlugin

var export_plugin: AndroidExportPlugin

func _enter_tree():
	export_plugin = AndroidExportPlugin.new()
	add_export_plugin(export_plugin)

func _exit_tree():
	remove_export_plugin(export_plugin)
	export_plugin = null

class AndroidExportPlugin extends EditorExportPlugin:
	func _supports_platform(platform):
		if platform is EditorExportPlatformAndroid:
			return true
		return false

	func _get_android_libraries(platform, debug):
		if debug:
			return PackedStringArray(["SocialAnalytics/bin/debug/social_analytics-debug.aar"])
		else:
			return PackedStringArray(["SocialAnalytics/bin/release/social_analytics-release.aar"])

	func _get_name():
		return "SocialAnalytics"
    
    # Dependencies are now handled inside the AAR via Gradle, but Godot might need them explicitly if not using AAR's transitive deps?
    # Godot's build system usually merges manifests but might not pull transitive dependencies from AARs unless specified in build.gradle of the app.
    # But we can specify them here to be safe or if Godot requires it.
    # Actually, for Godot 4, we usually rely on the AAR including them or adding them to the main build.
    # Let's add them here just in case, or rely on the AAR.
    # If we use _get_android_dependencies, Godot adds them to the app's build.gradle.
	func _get_android_dependencies(platform, debug):
		return PackedStringArray([
            "com.facebook.android:facebook-android-sdk:17.0.0",
            "com.github.tiktok:tiktok-business-android-sdk:1.5.0"
        ])
