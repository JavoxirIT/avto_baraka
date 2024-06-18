import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyWeb extends StatefulWidget {
  const PrivacyWeb({super.key});

  @override
  State<PrivacyWeb> createState() => _PrivacyWebState();
}

class _PrivacyWebState extends State<PrivacyWeb> {
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.disabled)
    ..loadRequest(Uri.parse('https://avto-baraka.uz/privacy'));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy'),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
