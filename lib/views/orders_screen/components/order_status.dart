import 'package:my_estore/consts/consts.dart';

// ignore: must_be_immutable
class OrderStatus extends StatelessWidget {
  dynamic icon;
  dynamic color;
  dynamic title;
  bool showDone;
  
  OrderStatus({required this.color,required this.icon,required this.title,required this.showDone, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color,).box.roundedSM.padding(const EdgeInsets.all(4)).border(color: color).make(),
      trailing: SizedBox(
        height: 100,
        width: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            "$title".text.color(darkFontGrey).make(),
            showDone? const Icon(Icons.done, color: redColor,):Container()
          ],
        ),
      ),
    );
  }
}