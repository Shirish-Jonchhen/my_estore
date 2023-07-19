import "package:my_estore/consts/consts.dart";

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  String? title;
  Color? color;
  Color? textColor;
  void Function()? onPressed;


  CustomButton({this.color, this.title, this.textColor, this.onPressed ,super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.all(12)
      ),
      onPressed: onPressed, 
      child: title!.text.color(textColor).fontFamily(bold).make()
      
    );
  }
}