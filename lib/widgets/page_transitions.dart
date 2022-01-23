import 'package:flutter/material.dart';

// Route pageTransition(Widget ruta) {
//   return PageRouteBuilder(
//     pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
//       //
//       return ruta;
//     },
//     transitionDuration: const Duration(microseconds: 2000),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       final curvedAnimation = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
//       return FadeTransition(
//         child: child,
//         opacity: Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation),
//       );
//     },
//   );
// }

class FadeInRoute extends PageRouteBuilder {
  final Widget page;

  FadeInRoute({this.page, String routeName})
      : super(
          settings: RouteSettings(name: routeName), // set name here
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
          transitionDuration: const Duration(milliseconds: 500),
        );
}
