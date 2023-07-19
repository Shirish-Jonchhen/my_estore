import 'package:get/get.dart';
import 'package:my_estore/consts/consts.dart';
import 'package:my_estore/consts/list.dart';
import 'package:my_estore/controllers/auth_controller.dart';
import 'package:my_estore/views/authentication/signup_Screen.dart';
import 'package:my_estore/views/home_screen/home.dart';
import 'package:my_estore/widgets/applogo.dart';
import 'package:my_estore/widgets/bg_widgets.dart';
import 'package:my_estore/widgets/custom_button.dart';
import 'package:my_estore/widgets/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return BackgroudWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              const AppLogo(),
              10.heightBox,
              "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
              15.heightBox,
              Obx(
                ()=> Column(
                  children: [
                    CustomTextField(title: email,hint: emailHint,isPass: false, controller: controller.emailController,),
              
                    CustomTextField(title: password,hint: passwordHint, isPass: true, controller: controller.passwordController,),
                    
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: (){}, 
                        child: forgetPassword.text.make()
                      )
                    ),
              
                    5.heightBox,
              
                    controller.isLoading.value? 
                    const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    )
                    : CustomButton(
                      title: login , 
                      color: redColor, 
                      textColor: whiteColor, 
                      onPressed: () => loginPressed(controller, context),
                    ).box.width(context.screenWidth-50).make(),
                    
                    5.heightBox,
                    
                    createNewAccount.text.color(fontGrey).make(),
                    
                    CustomButton(title: signup , color: lightGolden, textColor: redColor, onPressed: (){Get.to(()=>SignupScreen());}, ).box.width(context.screenWidth-50).make(),
                    
                    10.heightBox,
                    
                    loginWith.text.color(fontGrey).make(),
                    
                    5.heightBox,
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(socialIconList.length
                      , (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: lightGrey,
                          child: Image.asset(socialIconList[index], width: 30,),
                        ),
                      )),
                    )
                  ],
                ).box.white.rounded.padding(const EdgeInsets.all(16)).width(context.screenWidth-70).shadowSm.make(),
              ),

            ],
            )
          ),
      ) 
    );
  }

  loginPressed( AuthController controller, BuildContext context) async{
    controller.isLoading(true);

    await controller.loginMethod(context).then((value){
      if(value != null){
        VxToast.show(context, msg: logggedinToast);
        Get.offAll(()=> const Home());
      }else{
        controller.isLoading(false);
      }
    });
  }
}