import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:my_estore/consts/consts.dart';
import 'package:my_estore/views/authentication/login_screen.dart';
import 'package:my_estore/views/home_screen/home.dart';
import 'package:my_estore/widgets/applogo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  //Change Screen function

  changeScreen(){
    Future.delayed(const Duration(seconds: 3),(){
      //Using Getx
      // Get.to(()=> const LoginScreen());

      auth.authStateChanges().listen((User? user) {
        if(user == null && mounted){
          Get.to(()=>const LoginScreen());
        }else{
          Get.to(()=>const Home());
        }
       });
    });
  }

  @override
  void initState() {
    // runs at the start of the application
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: Center(
        child: Column(
          children: [
          Align(
            //bakcgroung image (Arrow with a click)
            alignment: Alignment.topLeft,
            child: Image.asset(icSplashBg, width: 300,)
          ),
          20.heightBox,
          const AppLogo(),
          10.heightBox,
          appname.text.fontFamily(bold).size(22).white.make(),
          5.heightBox,
          appversion.text.white.make(),
          const Spacer(),
          credits.text.fontFamily(semibold).white.make(),
          30.heightBox

          ],
        ),
      ),
    );
  }
}