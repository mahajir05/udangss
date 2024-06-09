import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../cores/utils/app_util.dart';

class ShrimpNewsScreen extends StatefulWidget {
  final String id;
  const ShrimpNewsScreen({super.key, required this.id});

  @override
  State<ShrimpNewsScreen> createState() => _ShrimpNewsScreenState();
}

class _ShrimpNewsScreenState extends State<ShrimpNewsScreen> {
  late WebViewController controller;
  double progressLoading = 0.0;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            setState(() {
              progressLoading = progress / 100;
            });
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          // onNavigationRequest: (NavigationRequest request) {
          //   return NavigationDecision.navigate;
          // },
        ),
      )
      ..loadRequest(Uri.parse('https://app.jala.tech/web_view/posts/${widget.id}'));
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(t.lblShrimpNews),
        actions: [
          IconButton(
            onPressed: () {
              AppUtils.share("https://app.jala.tech/posts/${widget.id}");
            },
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: Column(
        children: [
          if (progressLoading < 1)
            LinearProgressIndicator(
              value: progressLoading.toDouble(),
            ),
          Expanded(child: WebViewWidget(controller: controller)),
        ],
      ),
    );
  }
}
