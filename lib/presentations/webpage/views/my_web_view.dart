import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/my_web_controller.dart';

class MyWebView extends GetView<MyWebController> {
  MyWebView({Key? key}) : super(key: key);
  final GlobalKey webViewKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyWebController>(
        init: MyWebController(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: () async {
              controller.inAppWebViewController.goBack();
              return false;
            },
            child: Scaffold(
              /* appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                title: Image.asset(
                  "assets/name_logo.png",
                  scale: 4,
                ),
                centerTitle: true,
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      controller.inAppWebViewController.reload();
                    },
                  ),
                ],
              ),*/
              body: SafeArea(
                child: Column(
                  children: [
                    controller.progress < 0.9
                        ? LinearProgressIndicator()
                        : SizedBox(),
                    Expanded(
                      child: InAppWebView(
                        key: webViewKey,
                        initialOptions: controller.options,
                        onWebViewCreated: (webController) {
                          controller.inAppWebViewController = webController;
                        },
                        initialUrlRequest: URLRequest(
                            url: Uri.parse('https://souqaljomaakw.com/')),
                        onLoadStart: (ctrl, url) {
                          controller.assignURl(url);
                        },
                        androidOnPermissionRequest:
                            (ctrl, origin, resources) async {
                          return PermissionRequestResponse(
                              resources: resources,
                              action: PermissionRequestResponseAction.GRANT);
                        },
                        onLoadError: (ctrl, url, code, message) {
                          controller.pullToRefreshController.endRefreshing();
                          controller.showError();
                        },
                        onLoadHttpError: (ctrl, url, int i, s) async {
                          print('CUSTOM_HANDLER: $i, $s');
                          /** instead of printing the console message i want to render a static page or display static message **/
                          controller.showError();
                        },
                        onProgressChanged: (ctrl, progress) {
                          if (progress == 100) {
                            controller.pullToRefreshController.endRefreshing();
                          }
                          controller.onChangedProgress(progress);
                        },
                        shouldOverrideUrlLoading: (controller,
                            shouldOverrideUrlLoadingRequest) async {
                          var url = shouldOverrideUrlLoadingRequest.request.url;
                          var uri = url;

                          if ((uri.toString())
                              .startsWith('https://souqaljomaakw.com/')) {
                            return NavigationActionPolicy.ALLOW;
                            ;
                          } else {
                            _launchURL(uri.toString());
                            return NavigationActionPolicy.CANCEL;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
