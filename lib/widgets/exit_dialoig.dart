import 'package:flutter/services.dart';
import 'package:my_estore/consts/consts.dart';
import 'package:my_estore/widgets/custom_button.dart';

class ExitDialog extends StatelessWidget {
  const ExitDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          "Confirm Exit".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
          Divider(),
          10.heightBox,
          "Are you Sure yoiu want to exit".text.size(16).color(darkFontGrey).make(),
          10.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                color: redColor,
                onPressed: (){
                  SystemNavigator.pop();
                },
                textColor: whiteColor,
                title: "Yes",
              ),

              CustomButton(
                color: redColor,
                onPressed: (){
                  Navigator.pop(context);
                },
                textColor: whiteColor,
                title: "No",
              ),
            ],
          )
        ],
      ).box.color(lightGrey).padding(const EdgeInsets.all(12)).roundedSM.make(),
    );
  }
}