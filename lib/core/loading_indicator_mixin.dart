// 🎯 Dart imports:
import 'dart:ui';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:lottie/lottie.dart';

mixin LoadingIndicatorMixin<T extends StatefulWidget> on State<T> {
  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    _removeLoadingIndicatorOverlay();
    super.dispose();
  }

  //
  //  LOADING INDICATOR
  //
  void showLoadingIndicator() => _insertLoadingIndicatorOverlay();

  void removeLoadingIndicator() => _removeLoadingIndicatorOverlay();

  void _insertLoadingIndicatorOverlay() {
    _overlayEntry = OverlayEntry(
      builder: (_) => _loadingIndicator,
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeLoadingIndicatorOverlay() {
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

  //
  //  SUCCESS INDICATOR
  // (with optional message)
  void showSuccessIndicator({
    String? message,
    VoidCallback? onDismissed,
  }) {
    _insertSuccessIndicatorOverlay(
      message: message,
      onDismissed: onDismissed,
    );
  }

  void _insertSuccessIndicatorOverlay({
    String? message,
    VoidCallback? onDismissed,
  }) {
    _overlayEntry = OverlayEntry(
      builder: (_) => _successIndicator(
        message: message,
        onDismissed: onDismissed,
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeSuccessIndicatorOverlay([VoidCallback? onDismissed]) {
    _overlayEntry?.remove();
    _overlayEntry = null;
    onDismissed?.call();
  }

  Widget _successIndicator({String? message, VoidCallback? onDismissed}) {
    return GestureDetector(
      onTap: () => _removeSuccessIndicatorOverlay(onDismissed),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 1,
          sigmaY: 1,
        ),
        child: ColoredBox(
          color: Colors.black.withOpacity(0.75),
          child: Stack(
            children: [
              Positioned.fill(
                child: Lottie.asset(
                  'assets/lottie/success_Indicator.json',
                  repeat: false,
                ),
              ),
              if (message != null)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Material(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      child: Text(
                        message,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
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
