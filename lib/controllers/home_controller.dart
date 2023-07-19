import 'package:get/get.dart';
import 'package:my_estore/consts/consts.dart';

class HomeController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    getUserName();
    super.onInit();
  }
  
  var currentNavIndex = 0.obs;

  var userName = '';

  var searchController = TextEditingController();

  getUserName() async{
   var name = await firestore.collection(usersCollection).where('id', isEqualTo: currentUser!.uid).get().then((value){
      if(value.docs.isNotEmpty){
        return value.docs.single['name'];
      }
    });
    userName = name;
  }
}