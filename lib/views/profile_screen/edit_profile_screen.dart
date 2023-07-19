import 'dart:io';

import 'package:get/get.dart';
import 'package:my_estore/views/profile_screen/profile_controller.dart';
import 'package:my_estore/widgets/bg_widgets.dart';
import 'package:my_estore/consts/consts.dart';
import 'package:my_estore/widgets/custom_button.dart';
import 'package:my_estore/widgets/custom_textfield.dart';

class EditProfileScreen extends StatelessWidget {

  final dynamic data;

  const EditProfileScreen({this.data,super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.find<ProfileController>();


    
    return BackgroudWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: Obx(
          ()=>Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              SizedBox(
                height: 100,
                child: data['imageUrl']=='' && controller.profileImagePath.isEmpty ?
                Image.asset(imgProfile2, width: 100, fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make():

                data['imageUrl']!='' && controller.profileImagePath.isEmpty ?
                Image.network(data['imageUrl'],width: 100, fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make():

                Image.file(File(controller.profileImagePath.value),width: 100, fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make(),
        
              ),
              
              10.heightBox,
        
              CustomButton(
                color: redColor,
                onPressed: (){
                  controller.changeImage(context);
                },
                textColor: whiteColor,
                title: "Change",
              ),
        
              const Divider(),
              
              20.heightBox,
        
              CustomTextField(
                controller: controller.nameController,
               hint: nameHint,
               title: name,
               isPass: false, 
              ),
        
              CustomTextField(
                controller: controller.oldPasswordController,
               hint: passwordHint,
               title: password,
               isPass: true, 
              ),

              CustomTextField(
                controller: controller.newPasswordController,
               hint: passwordHint,
               title: newPass,
               isPass: true, 
              ),
        
              20.heightBox,

              controller.isloading.value?
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              ) :
              SizedBox(
                width:context.screenWidth -60 ,
                child: CustomButton(
                  color: redColor, 
                  textColor: whiteColor, 
                  title: "Save Changes",
                  onPressed: ()async{
                    controller.isloading(true);

                    //if new image given use new image
                    if(controller.profileImagePath.value.isNotEmpty){
                      await controller.uploadProfileImage();
                    
                    //else use the old image
                    }else{
                      controller.profileImageLink = data["imageUrl"];
                    }

                    //if old password matches
                    if(data['password'] == controller.oldPasswordController.text){

                      await controller.changeAuthPassword(
                        email: data['email'],
                        password: controller.oldPasswordController.text,
                        newPassword: controller.newPasswordController.text,
                      );

                      await controller.updateProfile(
                        imgUrl:controller.profileImageLink,
                        name: controller.nameController.text,
                        password: controller.newPasswordController.text,
                      );
                      VxToast.show(context, msg: "Profile Updated");
                    }else{
                      VxToast.show(context, msg: "Old Password Doesn't Match");
                      controller.isloading(false);
                    }

                  },
                )
              ),
            ],
          ).box.white.shadowSm.rounded.padding(const EdgeInsets.all(16)).margin(const EdgeInsets.only(top: 50, left: 12, right: 12 )).make(),
        ),
      ),
    );
  }
}