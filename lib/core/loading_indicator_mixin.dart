import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

mixin LoadingIndicatorMixin<T extends StatefulWidget> on State<T> {
  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void showLoadingIndicator() => _insertOverlay();

  void removeLoadingIndicator() => _removeOverlay();

  void _insertOverlay() {
    _overlayEntry = OverlayEntry(
      builder: (_) => _loadingIndicator,
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  Widget get _loadingIndicator {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 1,
        sigmaY: 1,
      ),
      child: ColoredBox(
        color: Colors.black.withOpacity(0.75),
        child: Lottie.asset('assets/lottie/loader.json'),
      ),
    );
  }

  Widget buildWidget(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_overlayEntry != null) return false;
        return true;
      },
      child: buildWidget(context),
    );
  }
}
