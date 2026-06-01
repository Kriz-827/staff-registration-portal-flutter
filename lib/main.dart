import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:staff_reg_portal/themes/my_theme.dart';
import 'package:staff_reg_portal/themes/theme_provider.dart';
import 'package:provider/provider.dart';
import 'splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
await Firebase.initializeApp(options: 
const FirebaseOptions(
  apiKey: "AIzaSyAZXiA2UuWjcKgt7vZsk2kY1uwDu0unqzM",
    authDomain: "flutter-staff-project.firebaseapp.com",
    projectId: "flutter-staff-project",
    storageBucket: "flutter-staff-project.appspot.com",
    messagingSenderId: "414885565853",
    appId: "1:414885565853:web:330fd04577a5cec1cacb74"
    ));}else{
     await  Firebase.initializeApp();
    }
  
  
  
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeProvider saveTheme = ThemeProvider();

  void getCurrentTheme() async {
    saveTheme.themedata = await saveTheme.mytheme.gettheme();
  }

  @override
  void initState() {
    getCurrentTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return saveTheme;
        })
      ],
      child: Consumer<ThemeProvider>(builder: (context, themedata, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: Styles.themeData(themedata.getthemedata, context),
          home: const SplashScreen(),
        );
      }),
 
    );
  }
}

