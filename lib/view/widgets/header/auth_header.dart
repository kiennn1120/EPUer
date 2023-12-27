import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../../../res/constant/app_assets.dart';
import '../../../res/style/app_colors.dart';

class AuthHeader extends StatefulWidget {
  const AuthHeader({Key? key, required this.title}) : super(key: key);
  final String? title;

  @override
  State<AuthHeader> createState() => _AuthHeaderState();
}

class _AuthHeaderState extends State<AuthHeader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late final Animation<Offset> _animation =
      Tween(begin: Offset.zero, end: const Offset(0, 0.1)).animate(_controller);
  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 3))
      ..repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 110),
          child: Hero(
            tag: 'University',
            child: SlideTransition(
              position: _animation,
              child: Image.asset(
                AppAssets.iconUniversity,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 30, left: 10, bottom: 30),
            child: AnimatedTextKit(
              pause: const Duration(seconds: 3),
              totalRepeatCount: 2,
              animatedTexts: [
                TypewriterAnimatedText(widget.title ?? '',
                    textStyle: const TextStyle(
                      color: AppColors.title,
                      fontFamily: 'Serif',
                      fontSize: 20,
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
