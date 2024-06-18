import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsConditionWeb extends StatefulWidget {
  const TermsConditionWeb({super.key});

  @override
  State<TermsConditionWeb> createState() => _TermsConditionWebState();
}

class _TermsConditionWebState extends State<TermsConditionWeb> {
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.disabled)
    ..loadRequest(Uri.parse('https://avto-baraka.uz/terms'));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TERMS AND CONDITIONS'),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
