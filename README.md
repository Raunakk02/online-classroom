# Online Classroom

A new online classroom application built with Flutter.

## Getting Started

You'll need to setup the IDE and mobile device emulator on your local system.

1. **Development Environment**: You'll need to have the following installed:
    1. [Flutter SDK](https://flutter.dev/docs/get-started/install)
    2. [Android Studio](https://developer.android.com/studio)
   
2. **Firebase Integration**: You will need to create a new firebase project in your own firebase console. 
    1. While creating the project, also provide the `SHA-1` and `SHA-256` debug keys. 
    2. Follow the steps mentioned in the console, and **don't forget** to replace the google-services.json file in `android/app` folder with the one you downloaded from your firebase console.

## Command Line Steps

The process to run this project on your system is quite simple. Here's what you need to do.

1. Clone and change into the project.
    ```sh
    $ git clone https://github.com/Raunakk02/online-classroom.git
    $ cd maser
    ```
1. Install packages
    ```sh
    $ flutter pub get
    ```
1. Start developing!

**Note**: If you face any build errors, then follow these steps:

    1. Try deleting the `pubspec.lock` file.
    2. After that, run `flutter clean` to remove the previous build.
    3. Finally run `flutter pub get`, to fetch all the packages in `pubspec.yaml` file.
    4. Now try to run the project with `flutter run`.
