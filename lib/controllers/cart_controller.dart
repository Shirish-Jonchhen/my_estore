import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:my_estore/consts/consts.dart';
import 'package:my_estore/controllers/home_controller.dart';

class CartController extends GetxController{
  var totalP = 0.obs;


  //text conrollers for shipping details
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var countryController = TextEditingController();
  var postalCodeController = TextEditingController();
  var phoneController = TextEditingController();

  var paymentIndex = 0.obs;

  late dynamic productSnapshot;
  var products = [];

  var placingOrder = false.obs;


  calculate(data){
    totalP.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalP = totalP + int.parse(data[i]['total_price'].toString());

    }
  }

  changePaymentIndex(index){ 
    paymentIndex.value = index;
  }

  getProductDetails(){
    products.clear();
    for (var i = 0; i < productSnapshot.length; i++) {
      products.add({
        'color':productSnapshot[i]['color'],
        'img':productSnapshot[i]['img'],
        'vendor_id': productSnapshot[i]['vendor_id'],
        'total_price': productSnapshot[i]['total_price'],
        'quantity': productSnapshot[i]['quantity'],
        'title': productSnapshot[i]['title'],
      });
    }
  }

  placeOrder({required orderPaymentMethod, required totalAmount}) async{
    placingOrder(true);
    await getProductDetails();

    await firestore.collection(ordersCollection).doc().set({
      'order_code': "233981237",
      'order_date': FieldValue.serverTimestamp(),
      'order_by': currentUser!.uid,
      'order_by_name': Get.find<HomeController>().userName,
      'order_by_email': currentUser!.email,
      'order_by_address': addressController.text,
      'order_by_city':cityController.text,
      'order_by_country':countryController.text,
      'order_by_state':stateController.text,
      'order_by_phone':phoneController.text,
      'order_by_postal_code':postalCodeController.text,
      'shipping_method': 'Home Delivery',
      'payment_method': orderPaymentMethod,
      'order_placed': true,
      'order_confirmed': false,
      'order_delivered': false,
      'order_on_delivery': false,
      'total_amount':totalAmount,
      'orders': FieldValue.arrayUnion(products),

    });

    placingOrder(false);
  }

  clearCart(){
    for (var i = 0; i < productSnapshot.length; i++) {
      firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }
  }

}