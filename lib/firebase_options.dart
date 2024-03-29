// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDtn2hd4JeWDU4Hc_-3tLxFOSoFjIe-N9M',
    appId: '1:987774662066:web:2b942abde67b3108ff20ab',
    messagingSenderId: '987774662066',
    projectId: 'lavie-chat',
    authDomain: 'lavie-chat.firebaseapp.com',
    storageBucket: 'lavie-chat.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBVj8X71T58phg6C3b_XjSNCOqygSDTqrw',
    appId: '1:987774662066:android:a691f5d025eae1d0ff20ab',
    messagingSenderId: '987774662066',
    projectId: 'lavie-chat',
    storageBucket: 'lavie-chat.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCaqzf-ZrRmiERAPFZSW_NGCZQEDt93XkE',
    appId: '1:987774662066:ios:326d2dac8a75f684ff20ab',
    messagingSenderId: '987774662066',
    projectId: 'lavie-chat',
    storageBucket: 'lavie-chat.appspot.com',
    iosClientId:
        '987774662066-mj0alujng5pjjc1upq12tfeednvd45ie.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterHackathon',
  );
}
