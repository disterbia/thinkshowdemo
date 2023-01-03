import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wholesaler_partner/app/widgets/loading_widget.dart';

class WebViewWidget extends StatefulWidget {
  bool isLoading = false;
  String url;
  WebViewWidget({required this.url});

  @override
  State<WebViewWidget> createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<WebViewWidget> {
  @override
  Widget build(BuildContext context) {
    final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {Factory(() => EagerGestureRecognizer())};
    UniqueKey _key = UniqueKey();

    return widget.isLoading == true
        ? LoadingWidget()
        : WebView(
            javascriptMode: JavascriptMode.unrestricted,
            key: _key,
            gestureRecognizers: gestureRecognizers,

            // onPageStarted: (String url) {
            //   print('start');
            //   setState() {
            //     widget.isLoading = true;
            //   }
            // },
            // onPageFinished: (String url) {
            //   print('end');
            //   setState() {
            //     widget.isLoading = false;
            //   }
            // },
            initialUrl: widget.url,
          );
  }
}
