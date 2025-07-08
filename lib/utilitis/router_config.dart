import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
BuildContext? get currentContext_ => GoRouterConfig.router.routerDelegate.navigatorKey.currentContext;
class GoRouterConfig{
  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
    routes: <RouteBase>[

    ],
    // redirect: (BuildContext context, GoRouterState state) {
    //   if(!SharedPref.isLogin()) return LoginScreen.routeName;
    //   if(state.matchedLocation == LoginScreen.routeName && SharedPref.isLogin()) return "/${HomeScreen.routeName}";
    //
    //   if(state.matchedLocation == OTPScreen.routeName && state.extra == null){
    //     return ForgetPasswordScreen.routeName;
    //   }
    //   return null;
    // },
  );

  static CustomTransitionPage getCustomTransitionPage({required GoRouterState state, required Widget child}){
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
          child: child,
        );
      },
    );
  }
}





