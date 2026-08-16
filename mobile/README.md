# GongBoo Bible Android beta

This is a Capacitor Android shell for the live Supabase Bible app.

- Live app: `https://biblegongboo.github.io/bible/supabase/app/`
- App identifier: `org.gongboo.bible`
- Design: the app loads the live web application so quiz, content, map, and UI
  changes can be deployed from the web project without rebuilding the APK.

## One-time workstation setup

1. Install Android Studio with the Android SDK and an emulator or a physical-device driver.
2. Install a JDK 21 distribution. The current Android Studio embedded JDK may
   be newer than the Gradle wrapper supports, so verify `java -version` reports
   version 21 before building.
3. From this directory run `corepack pnpm install --frozen-lockfile`.
   The Android project is already present, so `cap add android` is only needed
   when creating a fresh wrapper without the `android/` directory.

Set the JDK 21 location for the current PowerShell terminal before running
Gradle:

```powershell
$env:JAVA_HOME = "C:\Program Files\Eclipse Adoptium\jdk-21"
$env:Path = "$env:JAVA_HOME\bin;$env:Path"
```

## Daily beta build

```powershell
corepack pnpm run android:sync
corepack pnpm run android:open
```

Android Studio can run the app on a connected Android phone. For a locally
installable beta APK, use `Build > Build APK(s)` in Android Studio or run:

```powershell
corepack pnpm run android:build:debug
```

The final Play Store build will add a signed release key, store listing assets,
privacy-policy link, and Android verification before publishing.
