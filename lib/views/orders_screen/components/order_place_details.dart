import 'package:my_estore/consts/consts.dart';

// ignore: must_be_immutable
class OrderPlacesDetails extends StatelessWidget {
  String title1;
  dynamic titleDetail1;

  String title2;
  dynamic titleDetail2;

  OrderPlacesDetails({required this.titleDetail2,required this.titleDetail1,required this.title2,required this.title1,super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title1.text.fontFamily(semibold).make(),
              "$titleDetail1".text.color(redColor).fontFamily(semibold).make()
            ],
          ),
          
          SizedBox(
            width: 130,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title2.text.fontFamily(semibold).make(),
                "$titleDetail2".text.make()
            
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}