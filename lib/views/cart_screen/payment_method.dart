import 'package:get/get.dart';
import 'package:my_estore/consts/consts.dart';
import 'package:my_estore/consts/list.dart';
import 'package:my_estore/controllers/cart_controller.dart';

import '../../widgets/custom_button.dart';
import '../home_screen/home.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.find<CartController>();

    return Obx(
      ()=> Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: "Choose Payment Method".text.fontFamily(semibold).color(darkFontGrey).make(),
        ),
    
        bottomNavigationBar:  SizedBox(
          height: 60,
          child: controller.placingOrder.value ? 
          const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(redColor),
            ),
          )
          :CustomButton(
            onPressed: ()async{
              await controller.placeOrder(orderPaymentMethod: paymentMethodsList[controller.paymentIndex.value] ,totalAmount: controller.totalP.value );
              await controller.clearCart();
              VxToast.show(context, msg: "Order Placed..");
              Get.offAll(const Home());
            },
            color: redColor,
            textColor: whiteColor,
            title: "Place Order",
          ),
        ),
    
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(
            ()=>Column(
              children: List.generate(
                paymentMethodsList.length, 
                (index){
                  return GestureDetector(
                    onTap: (){
                      controller.changePaymentIndex(index);
                    },
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: controller.paymentIndex.value == index? redColor: Colors.transparent,
                          width: 4,
                        )
                      ),
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Image.asset(paymentMethodsImagesList[index], width: double.infinity, colorBlendMode: controller.paymentIndex.value == index? BlendMode.darken : BlendMode.color,  color: controller.paymentIndex.value == index? Colors.black.withOpacity(0.4): Colors.transparent , height: 120, fit: BoxFit.cover,),
                          controller.paymentIndex.value == index ?
                          Transform.scale(
                            scale: 1.3,
                            child: Checkbox(
                              activeColor: Colors.green,
                              value: true, 
                              onChanged: (value){},
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                            ),
                          ):
                          Container(),
    
                          Positioned(
                            child: paymentMethodsList[index].text.white.fontFamily(semibold).size(16).make(),
                            bottom: 10,
                            right: 10,
                          ),
                        ],
                      ),
                  
                    ),
                  );
                }
              ),
            ),
          ),
        ),
      ),
    );
  }
}