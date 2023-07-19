import 'package:get/get.dart';
import 'package:my_estore/controllers/auth_controller.dart';
import 'package:my_estore/views/authentication/login_screen.dart';
import 'package:my_estore/views/home_screen/home.dart';
import '../../consts/consts.dart';
import '../../widgets/applogo.dart';
import '../../widgets/bg_widgets.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  bool isChecked = false;
  var controller = Get.put(AuthController());

  //text controllers
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();


 @override
  Widget build(BuildContext context) {
    return BackgroudWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              AppLogo(),
              10.heightBox,
              "Join the $appname".text.fontFamily(bold).white.size(18).make(),
              15.heightBox,
              Obx(
                ()=> Column(
                  children: [
                    CustomTextField(title: name,hint: nameHint, controller: nameController, isPass: false,),
                    CustomTextField(title: email,hint: emailHint,controller: emailController, isPass: false,),
                    CustomTextField(title: password,hint: passwordHint,controller: passwordController, isPass: true,),
                    CustomTextField(title: retypePassword,hint: passwordHint, controller: passwordRetypeController, isPass: true,),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: (){}, 
                        child: forgetPassword.text.make()
                      )
                    ),
                    5.heightBox,
                    Row(
                      children: [
                        Checkbox(value: isChecked, onChanged: (newValue){
                          setState(() {
                            isChecked = newValue!;
                          });
                        }, checkColor: redColor, activeColor: whiteColor,),
                        10.widthBox,
                        Expanded(
                          child: RichText(text: const TextSpan(
                            children: [TextSpan(text: "I agree to the ", style: TextStyle(
                                            fontFamily: regular,
                                            color: fontGrey,
                                          )
                                        ),
                                        TextSpan(text:termsAndConditions, style: TextStyle(
                                            fontFamily: regular,
                                            color: redColor,
                                          )
                                        ),
                                        TextSpan(text: " & ", style: TextStyle(
                                            fontFamily: regular,
                                            color: fontGrey,
                                          )
                                        ),
                                        TextSpan(text: privacyPloicy, style: TextStyle(
                                            fontFamily: regular,
                                            color: redColor,
                                          )
                                        ),
                        
                                      ]
                          )),
                        )
                      ],
                    ),
                    5.heightBox,
                    controller.isLoading.value?
                    const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    ):
                    CustomButton(
                      title: signup , 
                      color: isChecked == true? redColor : lightGrey, 
                      textColor: whiteColor, 
                      onPressed: () => signupPress(), 
                    ).box.width(context.screenWidth-50).make(),
                    
                    10.heightBox,
                    
                    RichText(text: const TextSpan(
                      children: [
                          TextSpan(
                            text: alreadyHaveAnAccount,
                            style: TextStyle(
                              fontFamily: bold,
                              color: fontGrey
                            )
                          ),
                          TextSpan(
                            text: login,
                            style: TextStyle(
                              fontFamily: bold,
                              color: redColor
                            )
                          )
                        ]
                      )
                    ).onTap(() {
                      Get.to(()=> const LoginScreen());
                    })
                  ],
                ).box.white.rounded.padding(const EdgeInsets.all(16)).width(context.screenWidth-70).shadowSm.make(),
              ),

            ],
            )
          ),
      ) 
    );
  }

  signupPress() async{
    if(isChecked != false){
      controller.isLoading(true);
      try{
        await controller.signupMethod(emailController.text, passwordController.text, context).then((value){
          return controller.storeUserData(
            email: emailController.text,
            password: passwordController.text,
            name: nameController.text
          );
        }).then((value){
          VxToast.show(context, msg: logggedinToast);
          Get.offAll(()=> const Home());
        });
      }catch(e){
        auth.signOut();
        VxToast.show(context, msg: e.toString());
        controller.isLoading(false);
      }
    }
  }
}