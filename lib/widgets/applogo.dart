import 'package:my_estore/consts/consts.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(icAppLogo).box.white.size(77, 77).padding(EdgeInsets.all(8)).rounded.make();
  }
}