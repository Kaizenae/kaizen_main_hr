import 'package:flutter/material.dart';

class SlideTranstion extends PageRouteBuilder {
  final Widget page;
  SlideTranstion({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            Animation<Offset> animationTween = Tween<Offset>(
                    begin: const Offset(1, 0), end: const Offset(0, 0))
                .animate(
                    CurvedAnimation(parent: animation, curve: Curves.linear));
            return SlideTransition(
              position: animationTween,
              child: child,
            );
          },
          transitionDuration: const Duration(
            seconds: 1,
          ),
        );
}

class SlideTranstionDownToUp extends PageRouteBuilder {
  final Widget page;
  SlideTranstionDownToUp({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            Animation<Offset> animationTween = Tween<Offset>(
                    begin: const Offset(0, 1), end: const Offset(0, 0))
                .animate(
                    CurvedAnimation(parent: animation, curve: Curves.linear));
            return SlideTransition(
              position: animationTween,
              child: child,
            );
          },
          transitionDuration: const Duration(
            seconds: 1,
          ),
        );
}
