import 'package:my_estore/consts/consts.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  String? title;
  String? hint;
  bool isPass;
  // ignore: prefer_typing_uninitialized_variables
  var controller;

  CustomTextField({this.title, this.hint, this.controller, required this.isPass, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title!.text.color(redColor).fontFamily(semibold).size(16).make(),
        5.heightBox,
        TextField(
          obscureText: isPass,
          controller: controller,
          decoration: InputDecoration(
            hintStyle: const TextStyle(
              fontFamily: semibold,
              color: textfieldGrey,
            ),
            hintText: hint,
            isDense: true,
            fillColor: lightGrey,
            border: InputBorder.none,
            focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: redColor))
          ),
        ),
        5.heightBox
      ],
    );
  }
}