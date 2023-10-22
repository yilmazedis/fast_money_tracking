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
        return macos;
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
    apiKey: 'AIzaSyCqjvD7ORZY4qmRuX8AwTlr1_Gp8CvkPT8',
    appId: '1:96327565802:web:0a246531c8fcecdce13293',
    messagingSenderId: '96327565802',
    projectId: 'fast-money-tracking',
    authDomain: 'fast-money-tracking.firebaseapp.com',
    storageBucket: 'fast-money-tracking.appspot.com',
    measurementId: 'G-Y0859TN9DP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC5uXjKTMp1bWf8Z-VAQouiwlsm4M86nAY',
    appId: '1:96327565802:android:65fb7dfdeb27429ce13293',
    messagingSenderId: '96327565802',
    projectId: 'fast-money-tracking',
    storageBucket: 'fast-money-tracking.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAtmRKLsFRmXCXd_19cylMLg-1HZIu-ehA',
    appId: '1:96327565802:ios:7ad416d55ee54d3ae13293',
    messagingSenderId: '96327565802',
    projectId: 'fast-money-tracking',
    storageBucket: 'fast-money-tracking.appspot.com',
    iosBundleId: 'com.example.fastMoneyTracking',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAtmRKLsFRmXCXd_19cylMLg-1HZIu-ehA',
    appId: '1:96327565802:ios:79e246213429639be13293',
    messagingSenderId: '96327565802',
    projectId: 'fast-money-tracking',
    storageBucket: 'fast-money-tracking.appspot.com',
    iosBundleId: 'com.example.fastMoneyTracking.RunnerTests',
  );
}
