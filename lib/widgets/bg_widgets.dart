import 'package:flutter/widgets.dart';
import 'package:my_estore/consts/images.dart';

// ignore: must_be_immutable
class BackgroudWidget extends StatelessWidget {
  Widget? child;
  BackgroudWidget({this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(imgBackground), fit: BoxFit.fill)),
      child: child
    );
  }
}