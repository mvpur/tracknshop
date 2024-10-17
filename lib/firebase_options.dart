// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyBPD1im5YrgOg6XAKbSTxVlWaQlZRio7XM',
    appId: '1:647805084741:web:268cf260247654da472f2c',
    messagingSenderId: '647805084741',
    projectId: 'tracknshop-52ed3',
    authDomain: 'tracknshop-52ed3.firebaseapp.com',
    storageBucket: 'tracknshop-52ed3.appspot.com',
    measurementId: 'G-9RF4S5BY51',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyANe9YzRRzLHap0hFHEgXJQXlijOb9nhQI',
    appId: '1:647805084741:android:6b16dbf416b23c6a472f2c',
    messagingSenderId: '647805084741',
    projectId: 'tracknshop-52ed3',
    storageBucket: 'tracknshop-52ed3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBhyEPLqV-UfWKq_D1nqkJkppsSawwZwHc',
    appId: '1:647805084741:ios:7529b16923b0421f472f2c',
    messagingSenderId: '647805084741',
    projectId: 'tracknshop-52ed3',
    storageBucket: 'tracknshop-52ed3.appspot.com',
    iosBundleId: 'com.example.trackShopApp',
  );
}
