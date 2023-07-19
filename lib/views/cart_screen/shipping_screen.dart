import 'package:get/get.dart';
import 'package:my_estore/consts/consts.dart';
import 'package:my_estore/controllers/cart_controller.dart';
import 'package:my_estore/views/cart_screen/payment_method.dart';
import 'package:my_estore/widgets/custom_button.dart';
import 'package:my_estore/widgets/custom_textfield.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.find<CartController>();

    return Scaffold(
      backgroundColor: whiteColor
      ,
      appBar: AppBar(
        title: "Shipping Info".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: CustomButton(
          onPressed: (){
            if(controller.addressController.text.length>10){
              Get.to(()=> const PaymentMethods());
            }else{
              VxToast.show(context, msg: "Address must have at least 10 characters.");
            }
          },
          color: redColor,
          textColor: whiteColor,
          title: "Continue",
        ),
      ),


      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            CustomTextField(
              isPass: false,
              hint: "Address",
              title: "Address",
              controller: controller.addressController,
            ),
      
            CustomTextField(
              isPass: false,
              hint: "City",
              title: "City",
              controller: controller.cityController,

            ),
      
            CustomTextField(
              isPass: false,
              hint: "State",
              title: "State",
              controller: controller.stateController,

            ),
      
            CustomTextField(
              isPass: false,
              hint: "Country",
              title: "Country",
              controller: controller.countryController,

            ),
      
            CustomTextField(
              isPass: false,
              hint: "Postal Code",
              title: "Postal Code",
              controller: controller.postalCodeController,

            ),
      
            CustomTextField(
              isPass: false,
              hint: "Phone",
              title: "Phone",
              controller: controller.phoneController,
            ),
            
          ],
        ),
      ),
    );
  }
}