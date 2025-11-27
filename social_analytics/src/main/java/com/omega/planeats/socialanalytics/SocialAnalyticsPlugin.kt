package com.omega.planeats.socialanalytics

import android.app.Activity
import android.os.Bundle
import android.util.Log
import android.view.View
import com.facebook.appevents.AppEventsLogger
import com.tiktok.TikTokBusinessSdk
import com.tiktok.TikTokBusinessSdk.TTConfig
import org.godotengine.godot.Godot
import org.godotengine.godot.plugin.GodotPlugin
import org.godotengine.godot.plugin.UsedByGodot

class SocialAnalyticsPlugin(godot: Godot) : GodotPlugin(godot) {

    private var facebookLogger: AppEventsLogger? = null
    private lateinit var firebaseAnalytics: com.google.firebase.analytics.FirebaseAnalytics

    override fun getPluginName() = "SocialAnalytics"

    override fun onMainCreate(activity: Activity): View? {
        Log.d(pluginName, "Initializing SocialAnalyticsPlugin")

        // Initialize Firebase Analytics
        firebaseAnalytics = com.google.firebase.analytics.FirebaseAnalytics.getInstance(activity)
        Log.d(pluginName, "Firebase Analytics Initialized")

        // Initialize Facebook (Meta) SDK
        // Note: Facebook SDK auto-initializes if configured in Manifest, but we can force it here
        // or just get the logger
        // FacebookSdk.sdkInitialize(activity.applicationContext) // Deprecated, auto-init preferred
        // facebookLogger = AppEventsLogger.newLogger(activity) // Disabled by user request

        // Initialize TikTok SDK
        // Note: Replace with actual App ID and Access Token if not in Manifest, or load from
        // Manifest
        // For now, assuming manifest configuration or we can pass them from Godot
        // TikTokBusinessSdk.initialize(
        //     TTConfig(activity.applicationContext)
        //         .setAppId("bundle id") // TODO: Get from config
        //         .setTtAppId("tiktok app id")
        // )
        // Assuming TikTok is configured via Manifest meta-data for now, or we add a method to init

        return null
    }

    @UsedByGodot
    fun logEvent(eventName: String, params: org.godotengine.godot.Dictionary) {
        Log.d(pluginName, "Logging event: $eventName")

        // Meta (Facebook) - Disabled by user request
        /*
        val bundle = Bundle()
        for ((key, value) in params) {
            if (key is String) {
                when (value) {
                    is String -> bundle.putString(key, value)
                    is Int -> bundle.putInt(key, value)
                    is Float -> bundle.putFloat(key, value)
                    is Double -> bundle.putDouble(key, value)
                    is Boolean -> bundle.putBoolean(key, value)
                }
            }
        }
        facebookLogger?.logEvent(eventName, bundle)
        */

        // TikTok
        try {
            val jsonParams = org.json.JSONObject()
            for ((key, value) in params) {
                if (key is String) {
                    jsonParams.put(key, value)
                }
            }
            TikTokBusinessSdk.trackEvent(eventName, jsonParams)
            Log.d(pluginName, "TikTok event logged: $eventName with params: $jsonParams")
        } catch (e: Exception) {
            Log.e(pluginName, "Error logging TikTok event", e)
        }
    }

    @UsedByGodot
    fun initTikTok(
            appId: String,
            ttAppId: String,
            accessToken: String,
            enableDebug: Boolean = true
    ) {
        activity?.let {
            try {
                // Constructor: TTConfig(Context, AccessToken)
                val config =
                        TTConfig(it.applicationContext, accessToken)
                                .setAppId(appId)
                                .setTTAppId(ttAppId)

                if (enableDebug) {
                    TikTokBusinessSdk.enableDebugMode()
                    Log.d(pluginName, "TikTok Debug Mode Enabled")
                }

                TikTokBusinessSdk.initializeSdk(
                        config,
                        object : TikTokBusinessSdk.TTInitCallback {
                            override fun success() {
                                Log.d(pluginName, "TikTok SDK Initialization Successful")
                            }

                            override fun fail(code: Int, msg: String?) {
                                Log.e(
                                        pluginName,
                                        "TikTok SDK Initialization Failed: Code $code, Msg: $msg"
                                )
                            }
                        }
                )

                TikTokBusinessSdk.startTrack()
                Log.d(pluginName, "TikTok SDK initialized with App ID: $appId, TT App ID: $ttAppId")
            } catch (e: Exception) {
                Log.e(pluginName, "Error initializing TikTok SDK", e)
            }
        }
    }

    @UsedByGodot
    fun logFirebaseEvent(eventName: String, params: org.godotengine.godot.Dictionary) {
        val bundle = Bundle()
        for ((key, value) in params) {
            if (key is String) {
                when (value) {
                    is String -> bundle.putString(key, value)
                    is Int -> bundle.putInt(key, value)
                    is Float -> bundle.putFloat(key, value)
                    is Double -> bundle.putDouble(key, value)
                    is Boolean -> bundle.putBoolean(key, value)
                }
            }
        }
        firebaseAnalytics.logEvent(eventName, bundle)
        Log.d(pluginName, "Firebase event logged: $eventName with params: $bundle")
    }
}
