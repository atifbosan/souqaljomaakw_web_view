import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class MyWebController extends GetxController {
  late InAppWebViewController inAppWebViewController;
  late PullToRefreshController pullToRefreshController;
  bool showErrorPage = false;
  String url = '';
  double progress = 0;
  bool loading = false;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      preferredContentMode: UserPreferredContentMode.DESKTOP,
      javaScriptEnabled: true,
      useShouldOverrideUrlLoading: true,
      useOnDownloadStart: true,
      allowFileAccessFromFileURLs: true,
      mediaPlaybackRequiresUserGesture: false,
    ),
    android: AndroidInAppWebViewOptions(
      initialScale: 400,
      textZoom: 100,
      allowFileAccess: true,
      useShouldInterceptRequest: true,
      useHybridComposition: false,
    ),
    ios: IOSInAppWebViewOptions(
      allowsInlineMediaPlayback: true,
    ),
  );

  @override
  void onInit() {
    super.onInit();
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(color: Colors.blue),
      onRefresh: () async {
        if (Platform.isAndroid) {
          inAppWebViewController.reload();
        } else if (Platform.isIOS) {
          inAppWebViewController.loadUrl(
              urlRequest:
                  URLRequest(url: await inAppWebViewController.getUrl()));
        }
      },
    );
  }

  assignURl(urls) {
    url = urls.toString();
    update();
  }

  onChangedProgress(load) {
    progress = load / 100;
    update();
  }

  showError() {
    showErrorPage = true;
    update();
  }

  hideError() {
    showErrorPage = false;
    update();
  }
}
