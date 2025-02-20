import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyBXhhchTRxgm2oWMvxZO9uGb1kWpgTybq4',
    appId: '1:515761276359:web:48400455de1efe2ca645e2',
    messagingSenderId: '515761276359',
    projectId: 'mi-first-app-flutter',
    authDomain: 'mi-first-app-flutter.firebaseapp.com',
    storageBucket: 'mi-first-app-flutter.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBcAA37GwfMQyy2RveS6i-dsDv8uCHRZt4',
    appId: '1:515761276359:android:722d149c564bf0c2a645e2',
    messagingSenderId: '515761276359',
    projectId: 'mi-first-app-flutter',
    storageBucket: 'mi-first-app-flutter.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD-pfSFR8jPVzbGqr69cnvGZAl1lK5wJqw',
    appId: '1:515761276359:ios:61b873461ae0567fa645e2',
    messagingSenderId: '515761276359',
    projectId: 'mi-first-app-flutter',
    storageBucket: 'mi-first-app-flutter.firebasestorage.app',
    iosBundleId: 'com.example.miFirstApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD-pfSFR8jPVzbGqr69cnvGZAl1lK5wJqw',
    appId: '1:515761276359:ios:61b873461ae0567fa645e2',
    messagingSenderId: '515761276359',
    projectId: 'mi-first-app-flutter',
    storageBucket: 'mi-first-app-flutter.firebasestorage.app',
    iosBundleId: 'com.example.miFirstApp',
  );
}
