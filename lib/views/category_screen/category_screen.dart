import 'package:get/get.dart';
import 'package:my_estore/consts/consts.dart';
import 'package:my_estore/consts/list.dart';
import 'package:my_estore/controllers/product_controller.dart';
import 'package:my_estore/views/category_screen/category_details.dart';
import 'package:my_estore/widgets/bg_widgets.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen  ({super.key});

  @override
  Widget build(BuildContext context) {

    var controller =Get.put(ProductController());

    return BackgroudWidget(
      child: Scaffold(
        appBar: AppBar(
          title: category.text.fontFamily(bold).white.make(),
        ),
        body: Container(
          padding: const EdgeInsets.all(12),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing:8, crossAxisSpacing: 8, mainAxisExtent: 200 ), 
            itemBuilder: (context, index) => categoryBuilder(context, index, controller))
          ),
        ),
        
      );
  }

  categoryBuilder(context, index, ProductController controller){
    return Column(
      children: [
        Image.asset(categoryImagesList[index], height: 120, width: 200, fit: BoxFit.cover,),
        10.heightBox,
        categoryList[index].text.align(TextAlign.center).color(darkFontGrey).make()

      ],
    ).box.white.rounded.clip(Clip.antiAlias).outerShadowSm.make().onTap(() {
        controller.getSubCategories(categoryList[index]);
        Get.to(()=>CategoryDetails(title: categoryList[index]));
      });
  }

  
}
