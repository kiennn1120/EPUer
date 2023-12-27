import 'package:flutter/material.dart';
import '../../view/widgets/web_page.dart';

class LinkText extends StatelessWidget {
  final String text;
  final String link;

  const LinkText({Key? key, required this.text, required this.link}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebViewPage(url: link),
          ),
        );
      },
      child: Text(
        text,
        style: const TextStyle(color: Colors.blue),
      ),
    );
  }
}
