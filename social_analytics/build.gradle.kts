plugins {
    id("com.android.library")
    id("org.jetbrains.kotlin.android")
    id("com.google.gms.google-services")
}

android {
    namespace = "com.omega.planeats.socialanalytics"
    compileSdk = 34

    defaultConfig {
        minSdk = 21

        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
        consumerProguardFiles("consumer-rules.pro")
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
        }
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
    kotlinOptions {
        jvmTarget = "17"
    }
}

dependencies {
    implementation("com.github.tiktok:tiktok-business-android-sdk:1.5.0") // replace the version with the one which suits your need
    //to listen for app life cycle
    implementation("androidx.lifecycle:lifecycle-process:2.3.1")
    implementation("androidx.lifecycle:lifecycle-common-java8:2.3.1")
    //to get Google install referrer
    implementation("com.android.installreferrer:installreferrer:2.2")
    implementation("org.godotengine:godot:4.3.0.stable")
    implementation("com.facebook.android:facebook-android-sdk:17.0.0")
    implementation("com.google.firebase:firebase-analytics:22.1.2")
    // implementation("com.github.tiktok:tiktok-business-android-sdk:658e4e7")
}
