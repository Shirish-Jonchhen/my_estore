import 'package:my_estore/consts/consts.dart';

// ignore: must_be_immutable
class HomeButtons extends StatelessWidget {
  double width;
  double height;
  String icon;
  String title;
  void Function()? onPress;

  HomeButtons({required this.height, required this.icon, required this.onPress, required this.title, required this.width, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          icon,
          width: 26,
        ),
        10.heightBox,
        title.text.fontFamily(semibold).color(darkFontGrey).make()
      ],
    ).box.rounded.white.size(width, height).shadowSm.make();
  }
}