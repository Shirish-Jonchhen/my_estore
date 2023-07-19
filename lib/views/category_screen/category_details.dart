import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:my_estore/consts/consts.dart';
import 'package:my_estore/controllers/product_controller.dart';
import 'package:my_estore/views/category_screen/items_details.dart';
import 'package:my_estore/widgets/bg_widgets.dart';

import '../../services/firestore_services.dart';

class CategoryDetails extends StatefulWidget {
  final String title;
  const CategoryDetails({required this.title, super.key});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switchCategories(widget.title);
  }

  switchCategories(title){
    if(controller.subCategory.contains(title)){
      productMethod = FirestoreServices.getSubCategoryProducts(title);
    }else{
      productMethod = FirestoreServices.getProducts(title);
    }

  }

  var controller = Get.find<ProductController>();

  dynamic productMethod;

  @override
  Widget build(BuildContext context) {

    return BackgroudWidget(
      child: Scaffold(
        appBar: AppBar(
          title: widget.title.text.fontFamily(bold).white.make(),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  controller.subCategory.length, 
                  (index) => "${controller.subCategory[index]}"
                  .text
                  .size(12)
                  .fontFamily(semibold)
                  .color(darkFontGrey)
                  .makeCentered()
                  .box
                  .white
                  .size(120, 60)
                  .margin(const EdgeInsets.symmetric(horizontal: 4))
                  .rounded
                  .make()
                  .onTap((){
                    switchCategories("${controller.subCategory[index]}");
                    setState(() {
                      
                    });
                  }),
                ),
              ),
            ),

            20.heightBox,            

            StreamBuilder(
              stream: productMethod,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if(!snapshot.hasData){
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      )
                    ),
                  );
                }else if(snapshot.data!.docs.isEmpty){
                  return Expanded(
                    child: "No products Found".text.color(darkFontGrey).makeCentered(),
                  );
                }else{

                  var data = snapshot.data!.docs;

                  return Expanded(
                        child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 250, mainAxisSpacing: 8, crossAxisSpacing: 8), 
                          itemBuilder: (context, index){
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(data[index]['p_imgs'][0], width: 200, height: 150, fit: BoxFit.cover,),
                                  '${data[index]['p_name']}'.text.fontFamily(semibold).color(darkFontGrey).make(),
                                  10.heightBox,
                                  '${data[index]['p_price']}'.numCurrency.text.color(redColor).fontFamily(bold).size(16).make(),
                                  10.heightBox,
                                ],
                              ).box.white.margin(const EdgeInsets.symmetric(horizontal: 4)).roundedSM.outerShadowSm.padding(const EdgeInsets.all(12)).make().onTap(() {
                                controller.checkIfFav(data[index]);
                                Get.to(()=>ItemDetails(title: '${data[index]['p_name']}',data: data[index],));
                              });

                            }
                        )
                      );
                }
              },

              
            ),
          ],
        )
    ),
    );
  }
}