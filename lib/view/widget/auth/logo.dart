import 'package:ecommerce_app/constant/imageasset.dart';
import 'package:flutter/widgets.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(ImageAsset.LogoImageAsset, height: 125, width: 125);
  }
}
