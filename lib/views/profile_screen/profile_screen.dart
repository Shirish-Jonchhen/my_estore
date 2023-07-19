import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:my_estore/consts/consts.dart';
import 'package:my_estore/consts/list.dart';
import 'package:my_estore/controllers/auth_controller.dart';
import 'package:my_estore/services/firestore_services.dart';
import 'package:my_estore/views/authentication/login_screen.dart';
import 'package:my_estore/views/chat_screen/message_screen.dart';
import 'package:my_estore/views/orders_screen/orders_screen.dart';
import 'package:my_estore/views/profile_screen/components/details_card.dart';
import 'package:my_estore/views/profile_screen/edit_profile_screen.dart';
import 'package:my_estore/views/profile_screen/profile_controller.dart';
import 'package:my_estore/views/wishlist_screen/wishslist_screen.dart';
import 'package:my_estore/widgets/bg_widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen  ({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(ProfileController());

    return BackgroudWidget(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirestoreServices.getUser(currentUser!.uid),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

            if(!snapshot.hasData){
              return const Center(
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor)),
              );
            }else{
              var data = snapshot.data!.docs[0];

              return SafeArea(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [

                      //edit profile button
                      const Align(
                        alignment: Alignment.topRight,
                        child: Icon(Icons.edit, color: whiteColor)
                      ).onTap(() { 

                        controller.nameController.text = data['name'];


                        Get.to(()=>EditProfileScreen(
                          data: data
                          ));
                      }),


                      //userd details
                      Row(
                        children: [

                          SizedBox(
                            height: 100,
                            child: data['imageUrl'] == "" ?
                            Image.asset(imgProfile2, width: 100, fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make():
                            Image.network(data['imageUrl'], width: 100, fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make()
                          ,
                          )
                          ,
                          10.widthBox,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "${data['name']}".text.fontFamily(semibold).white.make(),
                                "${data['email']}".text.white.make(),
                              ],
                            )
                          ),

                          OutlinedButton(
                            onPressed: () => logoutPressed(context) ,
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: whiteColor
                              )
                            ),
                            child: logout.text.fontFamily(semibold).white.make(),
                          )
                        ],
                      ),

                      20.heightBox,

                      FutureBuilder(
                        future: FirestoreServices.getCounts(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData){
                            return const Center(
                              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor)),
                            );
                          }else {
                            var countData = snapshot.data;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                DetailsCard(count: "${countData[0]}", title: "in your cart"),
                                DetailsCard(count: "${countData[1]}", title: "in your wishlist"),
                                DetailsCard(count: "${countData[2]}", title: "your orders"),
                              ],
                            );
                          }
                        },
                      ),
                      


                      30.heightBox,

                      //buttons section
                      ListView.separated(
                        shrinkWrap: true,
                        itemCount: profileButtonsList.length,
                        itemBuilder: (context, index) => profileistBuilder(context,index), 
                        separatorBuilder: (context, index) {  
                          return const Divider(
                            color: lightGrey,
                          );
                        },
                      ).box.white.rounded.shadowSm.padding(const EdgeInsets.symmetric(horizontal: 16)).make(),
                
                      

                      
                    ],
                  ),
                ),
              );
            }
            
          },
          )
      ),
    );
  }



  profileistBuilder(context,index){
    return ListTile(
      onTap: (){
        switch (index) {
          case 0:
          Get.to(()=>const OrdersScreen());
            break;
          case 1:
            Get.to(()=>const WishlistScreen());
            break;
          case 2:
            Get.to(()=>const MessagesScreen());
            break;
        }
      },
      leading: Image.asset(profileButtonIconsList[index], width: 22,color: darkFontGrey,),
      title: profileButtonsList[index].text.fontFamily(semibold).color(darkFontGrey).make(),

    );
  }

  logoutPressed(context) async{
    await Get.put(AuthController()).signoutMethod(context);
    Get.offAll(() => const LoginScreen());
  }
}