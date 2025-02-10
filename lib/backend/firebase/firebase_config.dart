import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBMu13qnxXEwql7PJpRuiZ6dqPo0z-GVeE",
            authDomain: "to-do-qde1k5.firebaseapp.com",
            projectId: "to-do-qde1k5",
            storageBucket: "to-do-qde1k5.firebasestorage.app",
            messagingSenderId: "147604944959",
            appId: "1:147604944959:web:d66c385dbcc3d0975be08a"));
  } else {
    await Firebase.initializeApp();
  }
}
