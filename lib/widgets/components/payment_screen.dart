import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebViewScreen extends StatelessWidget {
  final String htmlData;

  const PaymentWebViewScreen({Key? key, required this.htmlData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadHtmlString(htmlData);

    return Scaffold(
      appBar: AppBar(title: Text("Payment")),
      body: WebViewWidget(controller: controller),
    );
  }
}
