import 'dart:convert';

import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class OrderTickeys extends StatelessWidget {
  const OrderTickeys({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => OrderTickeysState(), child: IndexPage());
  }
}

// Define a custom Form widget.
class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final cntroller = TextEditingController();

  void postData() async {
    // 'https://us-central1-bts-kenni-team-project.cloudfunctions.net/emailAPI-2'
    // 'https://asia-east1-bts-kenni-team-project.cloudfunctions.net/CreateTicket'
    var url = Uri.parse(
        'https://us-central1-bts-kenni-team-project.cloudfunctions.net/emailAPI-2');
    var response = await http.post(url, body: jsonEncode({'mail': 'BTS'}));
    setState(() {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('信用卡支付'),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(""),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              controller: cntroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Please enter your email',
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          // When the user presses the button, show an alert dialog containing
          // the text that the user has entered into the text field.
          onPressed: () {
            if (cntroller.text.isNotEmpty) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WebViewApp()));
            } else {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    // Retrieve the text the that user has entered by using the
                    // TextEditingController.
                    content: Text(cntroller.text.isNotEmpty
                        ? cntroller.text
                        : '請輸入email'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            }
          },
          tooltip: 'Show me the value!',
          child: const Icon(Icons.text_fields),
        ));
  }
}

class OrderTickeysState extends ChangeNotifier {
  var current = WordPair.random();
}

class OrderTickeysPage extends StatelessWidget {
  const OrderTickeysPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<OrderTickeysState>();

    return Scaffold(
      body: Column(
        children: [
          Text('A random AWESOME idea:'),
          Text(appState.current.asLowerCase),

          //add a button
          ElevatedButton(
            onPressed: () {
              // appState.current = WordPair.random();
              print('button pressed!');
            },
            child: Text('Next'),
          ),
        ],
      ),
    );
  }
}

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          setState(() {});
        },
        onProgress: (progress) {
          setState(() {});
        },
        onPageFinished: (url) {
          // print log when page finished loading
          setState(() {
            print('Page finished loading: $url');
          });
        },
      ))
      ..loadRequest(
        Uri.parse('https://buy.stripe.com/test_aEU29PcLw4585zi000'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
