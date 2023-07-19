import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:my_estore/views/splash_screen.dart';
import 'consts/consts.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: appname,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0.0, iconTheme: IconThemeData(color: darkFontGrey)),
        fontFamily: regular
      ),
      home: const SplashScreen(),
    );
  }
}

