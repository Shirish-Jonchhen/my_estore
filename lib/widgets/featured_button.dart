import 'package:get/get.dart';
import 'package:my_estore/consts/consts.dart';
import 'package:my_estore/views/category_screen/category_details.dart';

// ignore: must_be_immutable
class FeaturedButton extends StatelessWidget {
  String title;
  String icon;
  FeaturedButton({required this.icon, required this.title ,super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(icon, width: 60, fit: BoxFit.fill,),
        10.widthBox,
        title.text.fontFamily(semibold).color(darkFontGrey).make(),
      ],
    ).box.width(200).margin(const EdgeInsets.symmetric(horizontal: 4)).white.padding(const EdgeInsets.all(4.0)).roundedSM.outerShadowSm.make().onTap(() {
      Get.to(()=>CategoryDetails(title: title));
    });
  }
}