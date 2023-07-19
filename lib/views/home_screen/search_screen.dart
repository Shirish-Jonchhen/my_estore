import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:my_estore/consts/consts.dart';
import 'package:my_estore/services/firestore_services.dart';

import '../category_screen/items_details.dart';
 class SeacrchScreen extends StatelessWidget {

  final String? title;
  const SeacrchScreen({this.title ,super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: title!.text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: FutureBuilder(
        future: FirestoreServices.searchProducts(title),
        builder:(BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor)),
            );
          }else if(snapshot.data!.docs.isEmpty){
            return "No match found".text.makeCentered();
          }else{
            var data =snapshot.data!.docs;
            var filter = data.where((element) => element['p_name'].toString().toLowerCase().contains(title!.toLowerCase()),).toList();
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView(

                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 300, mainAxisSpacing: 8, crossAxisSpacing: 8),
                children: filter.mapIndexed((currentValue, index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(filter[index]['p_imgs'][0], width: 200, height: 200, fit: BoxFit.cover,),
                    const Spacer(),
                    "${filter[index]['p_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                    10.heightBox,
                    "\$ ${filter[index]['p_price']}".text.color(redColor).fontFamily(bold).size(16).make(),
                  ],
                ).box.white.outerShadowMd.margin(const EdgeInsets.symmetric(horizontal: 4)).roundedSM.padding(const EdgeInsets.all(12)).make().onTap(() {
                    Get.to(()=>ItemDetails(title:"${filter[index]['p_name']}", data: filter [index],));
                  })
                ).toList(),
              ),
            );
          }
          
        },
      ),
    );
  }
}