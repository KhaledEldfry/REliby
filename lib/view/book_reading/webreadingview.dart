import 'package:flutter/material.dart';
import 'package:reliby/view/account/account_view.dart';

import 'package:webview_flutter/webview_flutter.dart';

class NewsScreen extends StatefulWidget {
  final String bookName;
  final String bookContent;

  const NewsScreen(
      {Key? key, required this.bookName, required this.bookContent})
      : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Handle progress updates if needed
          },
          onPageStarted: (String url) {
            // Handle page started loading
          },
          onPageFinished: (String url) {
            // Handle page finished loading
          },
          onWebResourceError: (WebResourceError error) {
            // Handle web resource error
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(widget.bookContent)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.bookContent));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AccountView()));
          },
        ),
        title: Text(
          "${widget.bookName}",
          style: TextStyle(fontSize: 10),
        ),
      ),
      body: Container(
        // padding: EdgeInsets.only(top: 50, bottom: 50),
        child: WebViewWidget(controller: _controller),
      ),
    );
  }
}
