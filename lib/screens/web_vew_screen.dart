import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:news_app/api_service/api_service.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../widget/bold_text_main.dart';

class WebViewScreen extends StatefulWidget {
  String url;
  WebViewScreen({Key? key, required this.url}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: TextMain(
          text: "News",
        ),
        actions: [
          IconButton(
            onPressed: () {
              Share.share(widget.url);
            },
            icon: Icon(
              Icons.share,
              color: Colors.black,
            ),
          )
        ],
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: ApiService.getNews2(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: WebView(
                initialUrl: widget.url,
                onWebViewCreated: ((WebViewController webViewController) {
                  _controller.complete(webViewController);
                }),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
