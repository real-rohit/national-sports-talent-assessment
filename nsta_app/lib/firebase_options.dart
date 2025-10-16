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
    apiKey: 'AIzaSyBdj3gRDoGqAtVeuOENAfnaLRTRz5BE3WA',
    appId: '1:901961647006:web:58911fb0794ec95e134c8f',
    messagingSenderId: '901961647006',
    projectId: 'nsta-72472',
    authDomain: 'nsta-72472.firebaseapp.com',
    storageBucket: 'nsta-72472.firebasestorage.app',
    measurementId: 'G-DYLVTLK2L8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDUYrXPfjrswHMuU-a6O2rdGjjn4HDt1HE',
    appId: '1:901961647006:android:b9026086c4c0af54134c8f',
    messagingSenderId: '901961647006',
    projectId: 'nsta-72472',
    storageBucket: 'nsta-72472.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBOqVwZXrRGQNXmddRe-XGaRsBun_rYbNY',
    appId: '1:901961647006:ios:02e6c1372d1a7b87134c8f',
    messagingSenderId: '901961647006',
    projectId: 'nsta-72472',
    storageBucket: 'nsta-72472.firebasestorage.app',
    iosBundleId: 'com.example.nsta',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBOqVwZXrRGQNXmddRe-XGaRsBun_rYbNY',
    appId: '1:901961647006:ios:02e6c1372d1a7b87134c8f',
    messagingSenderId: '901961647006',
    projectId: 'nsta-72472',
    storageBucket: 'nsta-72472.firebasestorage.app',
    iosBundleId: 'com.example.nsta',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBdj3gRDoGqAtVeuOENAfnaLRTRz5BE3WA',
    appId: '1:901961647006:web:e4f108cbbb507ca2134c8f',
    messagingSenderId: '901961647006',
    projectId: 'nsta-72472',
    authDomain: 'nsta-72472.firebaseapp.com',
    storageBucket: 'nsta-72472.firebasestorage.app',
    measurementId: 'G-XW3GGPJZXW',
  );
}
