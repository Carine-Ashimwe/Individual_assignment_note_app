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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyBDRf9lZ-xa-SxFU2f5LcJNKdc_MuRM0Os',
    appId: '1:460141980414:web:a75cf61d1b3181f16553af',
    messagingSenderId: '460141980414',
    projectId: 'notes-app-ea21a',
    authDomain: 'notes-app-tj.firebaseapp.com',
    storageBucket: 'notes-app-tj.firebasestorage.app',
    measurementId: 'G-CXHG49RF9E',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCx-H_52Qu--zJ5R_RDOZ6xUd78wPbcooA',
    appId: '1:460141980414:android:352f96f02ab680136553af',
    messagingSenderId: '460141980414',
    projectId: 'notes-app-ea21a',
    storageBucket: 'notes-app-tj.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBjOqZTyAtDcys4JDpYoXrkGI9adCh68QQ',
    appId: '1:460141980414:ios:88f00db3ba0306316553af',
    messagingSenderId: '460141980414',
    projectId: 'notes-app-ea21a',
    storageBucket: 'notes-app-tj.firebasestorage.app',
    iosBundleId: 'com.example.notesApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBjOqZTyAtDcys4JDpYoXrkGI9adCh68QQ',
    appId: '1:460141980414:ios:88f00db3ba0306316553af',
    messagingSenderId: '460141980414',
    projectId: 'notes-app-ea21a',
    storageBucket: 'notes-app-tj.firebasestorage.app',
    iosBundleId: 'com.example.notesApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBDRf9lZ-xa-SxFU2f5LcJNKdc_MuRM0Os',
    appId: '1:460141980414:web:bbf4580d69507ac16553af',
    messagingSenderId: '460141980414',
    projectId: 'notes-app-ea21a',
    authDomain: 'notes-app-tj.firebaseapp.com',
    storageBucket: 'notes-app-tj.firebasestorage.app',
    measurementId: 'G-S3WTV21NH0',
  );
}
