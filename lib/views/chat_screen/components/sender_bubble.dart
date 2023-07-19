import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_estore/consts/consts.dart';
import 'package:intl/intl.dart' as intl;

// ignore: must_be_immutable
class SenderBubble extends StatelessWidget {
  DocumentSnapshot data;
  SenderBubble({required this.data, super.key});

  @override
  Widget build(BuildContext context) {

    var t = data['created_on'] == null ? DateTime.now(): data['created_on'].toDate();
    var time = intl.DateFormat("h:mma").format(t);


    return Directionality(
      textDirection: data['uid'] == currentUser!.uid ? TextDirection.rtl: TextDirection.ltr,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: data['uid'] == currentUser!.uid ? redColor:darkFontGrey,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: data['uid'] == currentUser!.uid ? const Radius.circular(20):const Radius.circular(0),
            bottomRight: data['uid'] == currentUser!.uid ? const Radius.circular(0):const Radius.circular(20),
          )
        ),
    
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "${data['message']}".text.white.size(16).make(),
            10.heightBox,
            time.text.color(whiteColor.withOpacity(0.5)).make()
          ],
        ),
      ),
    );
  }
}