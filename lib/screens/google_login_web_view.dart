import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'home_screen.dart';

class GoogleLoginWebView extends StatefulWidget {
  const GoogleLoginWebView({super.key});

  @override
  State<GoogleLoginWebView> createState() => _GoogleLoginWebViewState();
}

class _GoogleLoginWebViewState extends State<GoogleLoginWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      // ..setUserAgent(
      //     "Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Mobile Safari/537.36") // 💡 구글 차단 방지용
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            debugPrint('현재 이동 중인 주소: $url');

            // 🎯 성공 페이지 주소가 포함되어 있는지 확인
            if (url.contains("api.bookluck.org/login/success")) {
              debugPrint("🎯 로그인 성공 감지! 홈으로 이동합니다.");

              // 웹뷰 창을 닫고 홈으로 이동
              if (mounted) {
                Navigator.pop(context); // 웹뷰 닫기
                // Navigator.pushNamedAndRemoveUntil(
                //     context, '/home', (route) => false);
                Navigator.pushNamed(context, HomeScreen.id);
              }
            }
          },
        ),
      )
      ..loadRequest(
          Uri.parse('https://api.bookluck.org/oauth2/authorization/google'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: _controller),
    );
  }
}
