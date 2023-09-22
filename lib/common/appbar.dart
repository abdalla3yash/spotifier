import 'package:flutter/material.dart';
import 'package:spotifier/utils/utils.dart';

Widget defaultAppBar(BuildContext context) {
  return SliverAppBar(
    elevation: 0,
    stretch: true,
    pinned: true,
    backgroundColor: Theme.of(context).brightness == Brightness.light
        ? Theme.of(context).colorScheme.secondary
        : null,
    expandedHeight: MediaQuery.of(context).size.height / 5,
    flexibleSpace: FlexibleSpaceBar(
      centerTitle: true,
      background: ShaderMask(
        shaderCallback: (rect) {
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [blackColor, Colors.transparent],
          ).createShader(Rect.fromLTRB(
            0,
            0,
            rect.width,
            rect.height,
          ));
        },
        blendMode: BlendMode.dstIn,
        child: Center(
          child: Text(
            "Spotifier",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 70,
              color: whiteColor,
            ),
          ),
        ),
      ),
    ),
  );
}
