import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/my_web_controller.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

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
              body: controller.showErrorPage == true
                  ? Center(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/error-404.png",
                              scale: 2,
                            ),
                            Text(
                              "404 Page Not found",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "to reload the page\n press the following button",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                //: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            IconButton(
                              icon: Image.asset(
                                "assets/re_load.png",
                                scale: 2,
                              ),
                              onPressed: () {
                                controller.inAppWebViewController.reload();
                                controller.hideError();
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  : ModalProgressHUD(
                      progressIndicator: Container(
                        height: 110,
                        width: 90,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.black.withOpacity(0.5)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Loading...",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      inAsyncCall: controller.progress < 0.6 ? true : false,
                      child: SafeArea(
                        child: controller.showErrorPage == false
                            ? InAppWebView(
                                key: webViewKey,
                                initialOptions: controller.options,
                                onWebViewCreated: (webController) {
                                  controller.inAppWebViewController =
                                      webController;
                                },
                                initialUrlRequest: URLRequest(
                                    url: Uri.parse(
                                        'https://souqaljomaakw.com/')),
                                onLoadStart: (ctrl, url) {
                                  controller.assignURl(url);
                                },
                                androidOnPermissionRequest:
                                    (ctrl, origin, resources) async {
                                  return PermissionRequestResponse(
                                      resources: resources,
                                      action: PermissionRequestResponseAction
                                          .GRANT);
                                },
                                onLoadError: (ctrl, url, code, message) {
                                  controller.pullToRefreshController
                                      .endRefreshing();
                                  controller.showError();
                                },
                                onLoadHttpError: (ctrl, url, int i, s) async {
                                  print('CUSTOM_HANDLER: $i, $s');
                                  /** instead of printing the console message i want to render a static page or display static message **/
                                  controller.showError();
                                },
                                onProgressChanged: (ctrl, progress) {
                                  if (progress == 100) {
                                    controller.pullToRefreshController
                                        .endRefreshing();
                                  }
                                  controller.onChangedProgress(progress);
                                },
                                shouldOverrideUrlLoading: (controller,
                                    shouldOverrideUrlLoadingRequest) async {
                                  var url = shouldOverrideUrlLoadingRequest
                                      .request.url;
                                  var uri = url;
                                  print("Url:${uri.toString()}");
                                  if ((uri.toString()).startsWith(
                                      'https://souqaljomaakw.com/')) {
                                    return NavigationActionPolicy.ALLOW;
                                  } else {
                                    _launchURL(uri.toString());
                                    return NavigationActionPolicy.CANCEL;
                                  }
                                },
                              )
                            : Center(
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/error-404.png",
                                        scale: 2,
                                      ),
                                      Text(
                                        "404 Page Not found",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "to relead the page\n press the following button",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18,
                                          //: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      IconButton(
                                        icon: Image.asset(
                                          "assets/re_load.png",
                                          scale: 2,
                                        ),
                                        onPressed: () {
                                          controller.inAppWebViewController
                                              .reload();
                                          controller.hideError();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ),
                    ),
            ),
          );
        });
  }

/*  controller.progress < 0.9
  ? LinearProgressIndicator()
      : SizedBox(),
        controller.showErrorPage == false
  ?*/
  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
