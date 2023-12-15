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
    apiKey: 'AIzaSyCNczcBFNGbOnQzboIid4ffGu0kqfXcHrw',
    appId: '1:414407477341:web:3829ad4c10bad3b83fa5b4',
    messagingSenderId: '414407477341',
    projectId: 'mooc-e2aa2',
    authDomain: 'mooc-e2aa2.firebaseapp.com',
    storageBucket: 'mooc-e2aa2.appspot.com',
    measurementId: 'G-KP9ML39C1S',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCU9DAqC4R7ldRsZnpv2xLtujlDOfVcZjc',
    appId: '1:414407477341:android:13a5552d720f6aac3fa5b4',
    messagingSenderId: '414407477341',
    projectId: 'mooc-e2aa2',
    storageBucket: 'mooc-e2aa2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB-FMxaVc-DyHla3cOSAnBD40s9Si7qyAc',
    appId: '1:414407477341:ios:bf301647a72bac053fa5b4',
    messagingSenderId: '414407477341',
    projectId: 'mooc-e2aa2',
    storageBucket: 'mooc-e2aa2.appspot.com',
    iosBundleId: 'com.example.ezMooc',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB-FMxaVc-DyHla3cOSAnBD40s9Si7qyAc',
    appId: '1:414407477341:ios:3f86b24db40a69383fa5b4',
    messagingSenderId: '414407477341',
    projectId: 'mooc-e2aa2',
    storageBucket: 'mooc-e2aa2.appspot.com',
    iosBundleId: 'com.example.ezMooc.RunnerTests',
  );
}
