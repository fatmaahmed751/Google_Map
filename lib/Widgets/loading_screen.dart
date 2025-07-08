import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class LoadingScreen extends StatelessWidget {
  final Widget child;
  final bool loading;
  final Color? color;
  const LoadingScreen({
    Key? key,
    required this.child,
    this.loading = false,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          child,
          if (loading)
            Positioned.fill(
              child: Container(
                color:Colors.black26
                    // color ??
                    //     ThemeClass.of(context).mainBlack.withAlpha((0.2* 255).toInt()),
              ),
            ),
          if (loading)
            Positioned(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha((0.9* 255).toInt()),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: CupertinoActivityIndicator(
                  radius: 25,
                  color:Colors.grey,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
