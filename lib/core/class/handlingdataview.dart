import 'package:ecommerce_app/core/class/statusRequest.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class Handlingdataview extends StatelessWidget {
  final StatusRequest? statusRequest;
  final Widget widget;
  const Handlingdataview({super.key, this.statusRequest, required this.widget});
  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? Center(
          child: Lottie.asset(
            'assets/lotties/loading_spinner.json',
            width: 150,
            height: 150,
            repeat: true
          ),
        )
        : statusRequest == StatusRequest.offlineFailure
        ? Center(
          child: Lottie.asset(
            'assets/lotties/offline.json',
            width: 150,
            height: 150,
            repeat: true
          ),
        )
        : statusRequest == StatusRequest.serverFailure
        ? Center(
          child: Lottie.asset(
            'assets/lotties/404.json',
            width: 150,
            height: 150,
            repeat: true
          ),
        )
        : widget;
  }
}
