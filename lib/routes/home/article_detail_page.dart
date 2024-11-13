import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleDetailPage extends StatefulWidget {
  final String url;
  final String title;
  final bool collect;

  ArticleDetailPage({required this.url, required this.title, this.collect = false});

  @override
  State<ArticleDetailPage> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              webViewController?.reload();
            },
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(
                widget.collect ? Icons.favorite : Icons.favorite_border,
                color: widget.collect ? Colors.red : Colors.grey,
              )),
          IconButton(
              onPressed: () {
                launchUrl(Uri.parse(widget.url), mode: LaunchMode.externalApplication);
              },
              icon: Icon(Icons.open_in_new)),
        ],
      ),
      body: Column(
        children: [
          progress < 1.0 ? LinearProgressIndicator(value: progress) : Container(),
          Expanded(
            child: InAppWebView(
              key: webViewKey,
              initialUrlRequest: URLRequest(url: WebUri(widget.url)),
              initialSettings: InAppWebViewSettings(
                useShouldOverrideUrlLoading: true,
                mediaPlaybackRequiresUserGesture: false,
                useHybridComposition: true,
                allowsInlineMediaPlayback: true,
              ),
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              shouldOverrideUrlLoading: _shouldOverrideUrlLoading,
              onConsoleMessage: (controller, consoleMessage) {
                print("CONSOLE MESSAGE: ${consoleMessage.message}");
              },
              onLoadStart: (controller, url) {
                setState(() {
                  progress = 0;
                });
              },
              onProgressChanged: (controller, progress) {
                setState(() {
                  this.progress = progress / 100;
                });
              },
              onPermissionRequest: (controller, request) async {
                print(request);
                return PermissionResponse(resources: request.resources, action: PermissionResponseAction.GRANT);
              },
              onLoadStop: (controller, url) async {
                setState(() {
                  progress = 1.0;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<NavigationActionPolicy> _shouldOverrideUrlLoading(InAppWebViewController controller, NavigationAction navigationAction) async {
    var uri = navigationAction.request.url!;

    if (!["http", "https", "file", "chrome", "data", "javascript", "about"].contains(uri.scheme)) {
      if (await canLaunchUrl(uri)) {
        // 对于非 HTTP(S) URL，询问用户是否在外部打开
        bool shouldLaunch = await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("外部链接"),
                content: Text("是否打开外部应用 ${uri.scheme}?"),
                actions: <Widget>[
                  TextButton(
                    child: Text("取消"),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                  TextButton(
                    child: Text("打开"),
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                ],
              ),
            ) ??
            false;

        if (shouldLaunch) {
          await launchUrl(uri);
        }
      }
      return NavigationActionPolicy.CANCEL;
    }

    // 检查是否是恶意跳转（例如淘宝）
    if (uri.host.contains('taobao.com') || uri.host.contains('tmall.com')) {
      bool shouldLoad = await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("警告"),
              content: Text("检测到跳转到电商网站，是否继续？"),
              actions: <Widget>[
                TextButton(
                  child: Text("取消"),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                TextButton(
                  child: Text("继续"),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ],
            ),
          ) ??
          false;

      if (!shouldLoad) {
        return NavigationActionPolicy.CANCEL;
      }
    }

    return NavigationActionPolicy.ALLOW;
  }
}
