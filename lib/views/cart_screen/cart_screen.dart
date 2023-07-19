import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:my_estore/consts/consts.dart';
import 'package:my_estore/controllers/cart_controller.dart';
import 'package:my_estore/views/cart_screen/shipping_screen.dart';
import 'package:my_estore/widgets/custom_button.dart';

import '../../services/firestore_services.dart';

class CartScreen extends StatelessWidget {
  const CartScreen  ({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(CartController());


    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: 'Shopping Cart'.text.color(darkFontGrey).fontFamily(semibold).make(),
      ),

      bottomNavigationBar: SizedBox(
        height: 60,
        child: CustomButton(
          color: redColor,
          onPressed: (){
            Get.to(()=>const ShippingDetails());
          },
          textColor: whiteColor,
          title: "Proceed to Buy",
        ),
      ),

      body: StreamBuilder(
        stream: FirestoreServices.getCart(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor)),
            );
          }else if(snapshot.data!.docs.isEmpty){
            return Center(
              child: "Cart Is Empty".text.color(darkFontGrey).make(),
            );
          }else{
            var data =snapshot.data!.docs;
            controller.calculate(data);
            controller.productSnapshot = data;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Image.network('${data[index]['img']}', width: 80, fit: BoxFit.cover,),
                          title: "${data[index]['title']} (x${data[index]['quantity']})".text.fontFamily(semibold).size(16).make(),
                          subtitle: "${data[index]['total_price']}".numCurrency.text.size(14).color(redColor).fontFamily(semibold).make(),
                          trailing: const Icon(
                            Icons.delete,
                            color: redColor,
                          ).onTap(() {
                            FirestoreServices.deleteDocument(data[index].id);
                          }),

                        );
                      },
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Total Price".text.fontFamily(semibold).color(darkFontGrey).make(),
                      Obx(() => "${controller.totalP.value}".numCurrency.text.color(redColor).fontFamily(semibold).make()),
                    ],
                  ).box.padding(const EdgeInsets.all(12)).color(lightGolden).width(context.screenWidth-60).roundedSM.make(),

                  10.heightBox,
                  
                  // SizedBox(
                  //   width: context.screenWidth-60,
                  //   child: CustomButton(
                  //     color: redColor,
                  //     onPressed: (){},
                  //     textColor: whiteColor,
                  //     title: "Proceed to Buy",
                  //   ),
                  // )

                ],
                
              ),
            );
          }
        },
      ),

    );
  }
}