import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/state_manager.dart';

class WebviewBuilder extends StatelessWidget {
  RxString htmlContent;
  RxDouble height = 1.0.obs;
  WebviewBuilder({required this.htmlContent});

  @override
  Widget build(BuildContext context) {
    /// Define it to 1 else the Webview widget will not start loading.
    final html = Uri.dataFromString('''
                        <html lang="fr">
                           <meta name="viewport" content="width=device-width user-scalable=no zoom=1.1">
                           <style>img {max-width: 100%; height: auto}</style>
                           <body>
                            <div class="container" id="_flutter_target_do_not_delete">$htmlContent</div>
                            <script>
                            function outputsize() {
                                if (typeof window.flutter_inappwebview !== "undefined" && typeof window.flutter_inappwebview.callHandler !== "undefined")
                                   window.flutter_inappwebview.callHandler('newHeight', document.getElementById("_flutter_target_do_not_delete").offsetHeight);
                                }
                              new ResizeObserver(outputsize).observe(_flutter_target_do_not_delete)
                            </script>
                          </body>
                        </html>
                      ''', mimeType: "text/html", encoding: Encoding.getByName("utf-8"));

    return Obx(() => Container(
        height: height.value + 20,
        child: InAppWebView(
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
              supportZoom: false,
              javaScriptEnabled: true,
              disableHorizontalScroll: true,
              disableVerticalScroll: true,
            ),
          ),
          onWebViewCreated: (InAppWebViewController controller) {
            controller.addJavaScriptHandler(
                handlerName: "newHeight",
                callback: (List<dynamic> arguments) async {
                  int? height = arguments.isNotEmpty ? arguments[0] : await controller.getContentHeight();
                  if (height != null) {
                    this.height.value = height.toDouble();
                  }
                });
          },
          initialUrlRequest: URLRequest(url: html),
        )));
  }
}
