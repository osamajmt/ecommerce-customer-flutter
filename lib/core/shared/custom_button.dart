import 'package:ecommerce_app/constant/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomButton extends StatelessWidget {
  final String action;
  final Function()? onPressed;
  const CustomButton({super.key, required this.action, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 15),
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        onPressed:onPressed,
        color: AppColor.primaryColor,
        child: Text(
          action,
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
    );
  }
}
