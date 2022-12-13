
import 'package:flutter/material.dart';
import 'package:flutter_projects/Strings.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacySettingsPage extends StatefulWidget {
  const PrivacySettingsPage({Key? key}) : super(key: key);
  @override
  State<PrivacySettingsPage> createState() => _PrivacySettingsPage();
}

class _PrivacySettingsPage extends State<PrivacySettingsPage> {

  @override void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCFCFC),
        elevation: 0,
        leadingWidth: 48,
        centerTitle: true,
        title: const Text(
          Strings.privacyPolicy,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Image.asset('assets/ic_back.png'),
          padding: const EdgeInsets.only(left: 24),
        )  ,

      ),
      body: const Center(
        child: WebView(
          initialUrl: 'https://flutter.dev',
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
