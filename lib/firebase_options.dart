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
    apiKey: 'AIzaSyAdjF5oLsIQQ67oJsrcPPu9g0BfbOi_W1Y',
    appId: '1:615193419635:web:764bf874b821cc5d622f06',
    messagingSenderId: '615193419635',
    projectId: 'apexive-test',
    authDomain: 'apexive-test.firebaseapp.com',
    storageBucket: 'apexive-test.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCjDnpbSLwc7OwET5iTyXgEEu5qxmVC4zk',
    appId: '1:615193419635:android:30e1658ada3c80e6622f06',
    messagingSenderId: '615193419635',
    projectId: 'apexive-test',
    storageBucket: 'apexive-test.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDI21pK2WZLIx4sUs97lu4mRHoTC4UNC70',
    appId: '1:615193419635:ios:37e79fb327090baf622f06',
    messagingSenderId: '615193419635',
    projectId: 'apexive-test',
    storageBucket: 'apexive-test.appspot.com',
    iosClientId: '615193419635-5l35igj3onfgqq68a1gri7g7u62ojrop.apps.googleusercontent.com',
    iosBundleId: 'com.example.todoApp',
  );
}