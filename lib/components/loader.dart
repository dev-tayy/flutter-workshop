import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

class AppLoader {
  static void show(BuildContext context) {
    return Loader.show(
      context,
      progressIndicator: const CupertinoActivityIndicator(),
      overlayColor: Colors.white.withOpacity(0.4),
    );
  }

  static void hide() {
    return Loader.hide();
  }
}
