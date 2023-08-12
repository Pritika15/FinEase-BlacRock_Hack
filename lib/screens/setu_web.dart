import 'package:fin_ease/screens/form_page.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SetuWEB extends StatefulWidget {
  SetuWEB({required this.url});
  late String url;
  @override
  State<SetuWEB> createState() => _SetuWEBState();
}

class _SetuWEBState extends State<SetuWEB> {
  String? url;

  @override
  void initState() {
    url = widget.url;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            const CircularProgressIndicator();
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url!));
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FormPage()));
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                elevation: 5,
                shadowColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Icon(
                Icons.arrow_right_alt_rounded,
                color: Colors.white,
              )),
        ],
        title: Text('SETU CONSENT'),
      ),
      body: widget.url.isNotEmpty
          ? WebViewWidget(
              controller: controller,
              // initialUrl: _consentUrl,
              // javascriptMode: JavascriptMode.unrestricted,
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
