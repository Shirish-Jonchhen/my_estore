import 'package:get/get.dart';
import 'package:my_estore/consts/consts.dart';
import 'package:my_estore/controllers/home_controller.dart';
import 'package:my_estore/views/cart_screen/cart_screen.dart';
import 'package:my_estore/views/category_screen/category_screen.dart';
import 'package:my_estore/views/home_screen/home_screen.dart';
import 'package:my_estore/views/profile_screen/profile_screen.dart';
import 'package:my_estore/widgets/exit_dialoig.dart';

class Home extends StatelessWidget {
  const Home({super.key});
   
  @override
  Widget build(BuildContext context) {
    //init home controller
    var controller = Get.put(HomeController());

    var navBarItem = [
      BottomNavigationBarItem(icon: Image.asset(icHome, width: 26,), label: home ),
      BottomNavigationBarItem(icon: Image.asset(icCategories, width: 26,), label: category ),
      BottomNavigationBarItem(icon: Image.asset(icCart, width: 26,), label: cart ),
      BottomNavigationBarItem(icon: Image.asset(icProfile, width: 26,), label: account ),
    ];

  var navBody = [
    HomeScreen(),
    CategoryScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

    return WillPopScope(
      onWillPop: () async{
        showDialog(context: context, builder: (context)=> const ExitDialog(), barrierDismissible: false);
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Obx(()=>Expanded(
                child: navBody.elementAt(controller.currentNavIndex.value),
              )
            ), 
          ],
        ),
        bottomNavigationBar: Obx(()=> BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            selectedItemColor: redColor,
            selectedLabelStyle: const TextStyle(fontFamily: semibold),
            backgroundColor: whiteColor,
            type: BottomNavigationBarType.fixed,
            items: navBarItem,
            onTap: (Value){
              controller.currentNavIndex.value = Value;
            },
          ),
        ),
      ),
    );
  }
}