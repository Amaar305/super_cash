// ignore_for_file: unused_field

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class LiveChatPage extends StatelessWidget {
  const LiveChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LiveChatView();
  }
}

class LiveChatView extends StatefulWidget {
  const LiveChatView({super.key});

  @override
  State<LiveChatView> createState() => _LiveChatViewState();
}

class _LiveChatViewState extends State<LiveChatView> {
  late final WebViewControllerPlus _controller;
  bool _isLoading = true;
  bool _hasError = false;

  final String chatUrl = 'http://127.0.0.1:8000/api/v1/card/home/';

  @override
  void initState() {
    super.initState();
    _controller = WebViewControllerPlus()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) => setState(() => _isLoading = false),
          onWebResourceError: (error) => setState(() => _hasError = true),
        ),
      )
      ..loadRequest(Uri.parse(chatUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Chat'),
        leading: AppLeadingAppBarWidget(
          onTap: context.pop,
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // await ZohoChatService.setUserInfo(
            //   name: "Usman Ameen",
            //   email: "amarr@example.com",
            //   userId: "amarr123",
            // );
            // await ZohoChatService.showLiveChat();
          },
          child: const Text("Open Live Chat"),
        ),
      ),
      // body: Stack(
      //   children: [
      //     if (_hasError)
      //       const Center(child: Text("Failed to load live chat. Please try again later.")),
      //     if (!_hasError)
      //       WebViewWidget(controller: _controller),
      //     if (_isLoading)
      //       const Center(child: CircularProgressIndicator()),
      //   ],
      // ),
    );
  }
}
