# Moodle Native Mobile Assignment

This repository contains the solution for the Native Mobile Developer technical assignment.

The project is implemented for both platforms:

- `android/`: native Android app
android link : https://github.com/AsmaaHassenIbrahem/MoodleAndroid
- `ios/`: native iOS app
ios link : https://github.com/AsmaaHassenIbrahem/Moodle-iOS

## Assignment Scope

The app covers three main flows:

1. Courses screen
   - Fetch enrolled courses using `core_enrol_get_users_courses`
   - Show course name, progress, and image
2. Course details screen
   - Fetch course sections using `core_course_get_contents`
   - Show section titles
3. Grades screen
   - Fetch grades using `gradereport_user_get_grade_items`

## API Configuration

Base URL:

`https://moodle.itcorner.qzz.io`

REST endpoint:

`/webservice/rest/server.php`

Authentication options:

- Login endpoint: `/login/token.php`
- Demo username: `student1`
- Demo password: `Demo@12345`
- Pre-generated token is also supported

## Android

### Technologies

- Kotlin
- Jetpack Compose
- MVVM
- Koin
- Retrofit
- Moshi
- Kotlin Coroutines
- Coil
- Navigation Compose

### Structure

```text
android/
  app/src/main/java/io/qzz/moodlecandidate/
    appNavigation/
    di/
    feature/
      courses/
      courseDetails/
      grades/
    shared/
      config/
      constants/
      network/
      ui/
```

### Notes

- The Android app is organized by feature
- Each feature owns its own API interface, DTOs, repository, model, screen, and view model
- Shared concerns such as constants, UI state, and config are grouped under `shared/`
- Dependency injection is handled with Koin

### Setup

1. Open `android/` in Android Studio
2. Let Gradle sync
3. Run the `MoodleAndroid` app on an emulator or device

## iOS

### Technologies

- Swift
- SwiftUI
- MVVM
- Swinject
- Moya
- `async/await`
- `ObservableObject`
- `NavigationStack`

### Structure

```text
ios/MoodleCandidate/
  appNavigation/
  di/
  feature/
    courses/
    courseDetails/
    grades/
  shared/
    config/
    constants/
    network/
    session/
    ui/
```

### Notes

- The iOS app follows the same feature-based structure as Android
- Each feature owns its own model, repository, view model, and screen
- Shared app concerns are grouped under `shared/`
- Dependency injection is handled with Swinject
- Networking is implemented with Moya for a Retrofit-like API layer

### Setup

1. Open the `ios/` directory in Xcode
2. Select the `MoodleCandidate` scheme
3. Choose an iPhone simulator or connected device
4. Build and run

Optional:

- `ios/project.yml` is included if you want to regenerate the Xcode project with XcodeGen

## Architecture Summary

Both apps use the same high-level approach:

- MVVM
- Feature-based folder structure
- Repository layer between API and presentation
- Loading and error state handling
- Clear separation of shared concerns from feature-specific concerns

## Implementation Notes

- Progress is treated as optional because Moodle may not always return it
- Course image loading falls back when a direct image field is unavailable
- HTML-rich content is normalized before display where needed
- The apps are intentionally scoped to the assignment requirements and keep the UI clean and simple

## Submission Checklist

1. Run Android from Android Studio
2. Run iOS from Xcode
3. Verify the Moodle API responses using the provided credentials or token
4. Capture screenshots if required
5. Push the repository to GitHub
