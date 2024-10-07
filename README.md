
---

# Recipe Book

## Overview

**Recipe Book** is a Flutter-based mobile application designed to help users manage and discover a variety of recipes. The app provides features like browsing recipes, adding new ones, marking favorites, and viewing detailed instructions. It leverages a clean and intuitive UI to ensure a seamless user experience.

## Table of Contents

1. [Features](#features)
2. [Tech Stack](#tech-stack)
3. [Plugins Used](#plugins-used)
4. [Installation](#installation)
5. [Flutter Setup](#flutter-setup)
6. [Platform-specific Setup](#platform-specific-setup)
   - [Running on Android](#running-on-android)
   - [Running on iOS](#running-on-ios)
   - [Running on macOS](#running-on-macos)
   - [Running on Windows](#running-on-windows)
7. [Project Structure](#project-structure)
8. [Getting Started](#getting-started)
9. [Future Enhancements](#future-enhancements)

## Features

- **Recipe Management**: Users can browse, add, and manage their recipes.
- **Favorites**: Mark recipes as favorites for quick access.
- **Detailed Recipe View**: Step-by-step instructions for each recipe.
- **Intuitive UI**: Built using Flutter's `Material` and `Fluent UI` design principles.
- **Offline Access**: Uses local storage to save user preferences and recent searches.

## Tech Stack

The tech stack for this project was carefully chosen to optimize performance, scalability, and ease of development:

- **Flutter**: Chosen for its cross-platform capabilities, allowing us to target both iOS and Android with a single codebase. Flutter's expressive UI capabilities make it ideal for building beautiful applications quickly.
- **Supabase**: A powerful and open-source backend service that provides authentication, real-time data, and APIs for database operations. It seamlessly integrates with Flutter, making it easier to manage app data.
- **Dio & Retrofit**: These libraries handle HTTP requests and API interactions with elegant and type-safe code. They simplify data fetching, serialization, and error handling, making network operations more manageable.
- **Provider**: A state management solution that integrates easily with Flutter's widget tree. It allows for a more predictable and scalable way to manage the app's state.
- **Shared Preferences**: Used for local data storage to save user preferences and other non-sensitive data. It ensures that the app can provide a smooth experience even when offline.

## Plugins Used

### 1. **Provider**
   - **Purpose**: State management.
   - **Reason**: Provider is a lightweight, simple-to-use state management solution that integrates well with Flutter's widget tree. It helps maintain a reactive UI with minimal boilerplate code.

### 2. **Dio**
   - **Purpose**: Handling HTTP requests.
   - **Reason**: Dio is a powerful HTTP client for Dart that offers interceptors, global configuration, FormData, request cancellation, and more. It's well-suited for managing REST API calls in a structured way.

### 3. **Retrofit**
   - **Purpose**: API client code generation.
   - **Reason**: Retrofit simplifies the API request process by generating clean and type-safe code. It works seamlessly with Dio to streamline network operations.

### 4. **Json Annotation & Json Serializable**
   - **Purpose**: Data serialization.
   - **Reason**: These libraries make it easier to convert JSON data into Dart objects and vice versa, automating the code generation process and reducing boilerplate.

### 5. **Shimmer**
   - **Purpose**: Loading placeholders.
   - **Reason**: Shimmer provides a beautiful placeholder effect while data is loading, enhancing the user experience by indicating that content is being fetched.

### 6. **Fluent UI**
   - **Purpose**: User Interface.
   - **Reason**: Fluent UI components bring a modern and consistent design language to the app, aligning with Microsoft’s design principles. It ensures a sleek and professional look across the UI.

### 7. **Supabase Flutter**
   - **Purpose**: Backend services.
   - **Reason**: Supabase is an open-source Firebase alternative that provides user authentication, real-time data, and APIs. It's a perfect choice for building scalable apps with a solid backend.

### 8. **Shared Preferences**
   - **Purpose**: Local storage.
   - **Reason**: This plugin allows us to store user settings and preferences on the device, enabling offline capabilities and a more personalized user experience.

### 9. **App Links**
   - **Purpose**: Deep linking.
   - **Reason**: App Links allows for seamless navigation and integration with external sources, providing a more cohesive user experience when linking to or from other apps.


## Installation

To install the Recipe Book app on your local development environment, follow these steps:

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/recipe_book.git
   cd recipe_book
   ```

2. **Install the dependencies:**
   ```bash
   flutter pub get
   ```

## Flutter Setup

Before running the app, make sure you have Flutter installed and configured on your machine. Follow these steps based on your operating system:

### Prerequisites

1. **System Requirements**:
   - **Windows**: Windows 7 SP1 or later (64-bit), Visual Studio for desktop development.
   - **macOS**: macOS 10.14 or later, Xcode for iOS development.
   - **Linux**: Any 64-bit Linux distribution.

2. **Download Flutter SDK**:
   - Visit the [Flutter website](https://flutter.dev/docs/get-started/install) to download the latest version of the Flutter SDK for your platform.

3. **Add Flutter to your PATH**:
   - Extract the Flutter SDK to your desired location.
   - Add the Flutter tool to your system’s PATH variable.

4. **Verify installation**:
   - Open your terminal or command prompt and run:
     ```bash
     flutter doctor
     ```
   - Follow any prompts to install missing dependencies for your platform.

5. **Android Setup**:
   - **Install Android Studio** and set up the Android SDK.
   - Enable Developer Options and USB debugging on your Android device if you plan to use a physical device for testing.

6. **iOS Setup** (macOS only):
   - **Install Xcode** from the App Store.
   - Set up Xcode command-line tools:
     ```bash
     sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
     sudo xcodebuild -runFirstLaunch
     ```

7. **macOS and Windows Setup**:
   - For macOS and Windows desktop apps, make sure to enable desktop support:
     ```bash
     flutter config --enable-macos-desktop
     flutter config --enable-windows-desktop
     ```

## Platform-specific Setup

### Running on Android

1. **Start an Android Emulator** or connect a physical Android device.
2. Ensure you have an updated Android SDK installed.
3. Run the app:
   ```bash
   flutter run
   ```

### Running on iOS

1. **System Requirements**: You need a macOS system with Xcode installed.
2. Open iOS Simulator or connect a physical iOS device.
3. Run the app:
   ```bash
   flutter run
   ```

### Running on macOS

1. **Flutter Desktop Setup**: Ensure that your Flutter SDK supports macOS (Flutter 2.0+).
2. Run the app on macOS:
   ```bash
   flutter config --enable-macos-desktop
   flutter run -d macos
   ```

### Running on Windows

1. **Flutter Desktop Setup**: Ensure that you have the latest Flutter SDK and Visual Studio with the Desktop development workload installed.
2. Enable Windows Desktop support:
   ```bash
   flutter config --enable-windows-desktop
   ```
3. Run the app on Windows:
   ```bash
   flutter run -d windows
   ```

## Project Structure

```
lib/
|-- config/
|   |-- keys.dart                 # Contains API keys and sensitive information
|   |-- supabase_config.dart      # Configuration for Supabase integration
|
|-- core/
|   |-- constants.dart            # Application-wide constants
|
|-- features/
|   |-- fallouts/                 # Error handling and fallback logic
|   |-- recipes/                  # MVC structure for recipe management
|   |-- splash/                   # Splash screen logic and implementation
|
|-- widgets/
|   |-- reusable_widget.dart      # Common UI components used throughout the app
|
|-- dummy_data/                   # Static data for testing and development
|
|-- main.dart                     # Entry point of the Flutter application
```

### Explanation of the Structure

- **config/**: Holds configuration files such as API keys and Supabase setup.
- **core/**: Stores application-wide constants to maintain consistency in the codebase.
- **features/**: Organized by features with MVC (Model-View-Controller) pattern for modularity.
  - **fallouts/**: Manages error handling and fallback scenarios.
  - **recipes/**: Contains the recipe-related functionality.
  -

 **splash/**: Responsible for the splash screen and initialization logic.
- **widgets/**: Houses reusable UI components that can be used throughout the app.
- **dummy_data/**: Includes mock data for testing during development.
- **main.dart**: The entry point of the application, initializing all required configurations.

## Getting Started

This project is a starting point for Flutter development. For a detailed guide on how to start developing with Flutter, consider checking out these resources:

- [Flutter's online documentation](https://flutter.dev/docs)
- [Flutter Lab](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

## Future Enhancements

- **User Authentication**: Implement user accounts and login using Supabase's authentication services.
- **Recipe Sharing**: Allow users to share their favorite recipes with friends and family.
- **Push Notifications**: Notify users of new recipes or special features.
