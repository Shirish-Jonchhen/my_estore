import 'package:my_estore/consts/consts.dart';

// ignore: must_be_immutable
class DetailsCard extends StatelessWidget {
  String? count;
  String? title;
  DetailsCard({this.count, this.title ,super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        count!.text.fontFamily(bold).color(darkFontGrey).size(16).make(),
        5.heightBox,
        title!.text.color(darkFontGrey).make(),

      ],
    ).box.white.rounded.width(context.screenWidth /3.4).height(80).shadowSm.padding(const EdgeInsets.all(4)).make();
  }
}