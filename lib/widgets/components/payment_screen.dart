import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiwash_customer/route/route_strings.dart';
import 'package:hiwash_customer/styling/app_color.dart';
import 'package:hiwash_customer/styling/app_font_anybody.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../featuers/wash_status/controller/wash_status_controller.dart';
import '../../language/String_constant.dart';
import '../../network_manager/local_storage.dart' show LocalStorage;
import '../../styling/app_font_poppins.dart';

class PaymentWebViewScreen extends StatefulWidget {
  final String htmlData;

  const PaymentWebViewScreen({Key? key, required this.htmlData})
    : super(key: key);

  @override
  _PaymentWebViewScreenState createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
  late WebViewController _controller;

  final washStatusController = Get.find<WashStatusController>();

  @override
  void initState() {
    super.initState();

    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadHtmlString(widget.htmlData);

    callApi();
  }

  callApi() async {
    final userIdStr = LocalStorage().getUserId();
    if (userIdStr != null && int.tryParse(userIdStr) != null) {
      await washStatusController.getCustomerDataById(int.parse(userIdStr));
      final subscriptionId =
          washStatusController
              .getCustomerData
              .value
              ?.data
              ?.subscriptionDetails
              ?.subscriptionId;
      if (subscriptionId != null) {
        if (mounted) {
          Get.offAllNamed(RouteStrings.dashboardScreen, arguments: true);
        }
      } else {
        if (mounted) {
          await Future.delayed(Duration(seconds: 1));
          callApi();
        }
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _showExitConfirmationDialog(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Payment"),
          automaticallyImplyLeading: false,
        ),
        body: WebViewWidget(controller: _controller),
      ),
    );
  }
}

Future<bool> _showExitConfirmationDialog(BuildContext context) async {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          StringConstant.kConfirmExit.tr,
          style: w700_22a(color: AppColor.c2C2A2A),
        ),
        content: Text(
          StringConstant.kDoYouWantToCancelThePayment.tr,
          style: w400_16p(),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text(StringConstant.kNo.tr),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text(StringConstant.kYes.tr),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}

/*  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _timer?.cancel();
        Get.back();
        _showResultDialog(false);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Payment")),
        body: WebViewWidget(controller: _controller),
      ),
    );
  }*/
