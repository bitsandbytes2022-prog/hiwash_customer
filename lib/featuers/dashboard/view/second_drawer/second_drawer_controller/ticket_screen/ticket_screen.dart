  import 'package:flutter/material.dart';
  import 'package:webview_flutter/webview_flutter.dart';

  class TawkTicketPage extends StatefulWidget {
    @override
    State<TawkTicketPage> createState() => _TawkTicketPageState();
  }

  class _TawkTicketPageState extends State<TawkTicketPage> {
    late final WebViewController _controller;

    @override
    void initState() {
      super.initState();
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadRequest(
          Uri.parse('https://testcenter1.tawk.help/ticket'),
        );
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text('Submit a Ticket')),
        body: WebViewWidget(controller: _controller),
      );
    }
  }
