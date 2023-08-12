import 'package:fin_ease/providers/auth.dart';
import 'package:fin_ease/screens/dashboard.dart';

import 'package:fin_ease/screens/login_page.dart';
import 'package:fin_ease/screens/setu_web.dart';
import 'package:fin_ease/services/apis.dart';
import 'package:fin_ease/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'package:provider/provider.dart';

Widget? widget;
String ?url;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   url = await fetchConsentUrl();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // if (FirebaseAuth.instance.currentUser != null) {
  //   widget = await FirestoreService().checkIsInfos();
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Auth()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: 
        (FirebaseAuth.instance.currentUser != null)
            ? SetuWEB(url: url!)
            : LoginPage(),
       // Dashboard()
      ),
    );
  }
}
