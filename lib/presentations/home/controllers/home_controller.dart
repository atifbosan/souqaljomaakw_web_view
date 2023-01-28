import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class HomeController extends GetxController {
  late WebViewController webViewController;
  bool isLoading = true;
  @override
  void onInit() {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            isLoading = true;
            update();
          },
          onPageFinished: (String url) {
            isLoading = false;
            update();
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.google.com/')) {
              return NavigationDecision.navigate;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://staging.souqaljomaakw.com/'));
    super.onInit();
  }

  goBack() async {
    if (await webViewController.canGoBack()) {
      await webViewController.goBack();
    }
  }

  goForward() async {
    if (await webViewController.canGoForward()) {
      await webViewController.goForward();
    }
  }

  @override
  void onClose() {
    webViewController.clearCache();
    super.onClose();
  }
}
