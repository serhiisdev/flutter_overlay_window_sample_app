import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

class OverlayIncreaseButton extends StatefulWidget {
  const OverlayIncreaseButton({super.key});

  @override
  State<OverlayIncreaseButton> createState() => _OverlayIncreaseButtonState();
}

class _OverlayIncreaseButtonState extends State<OverlayIncreaseButton> {
  StreamSubscription<dynamic>? _overlayListener;

  Future<void> _onPressed() async {
    await FlutterOverlayWindow.shareData("Hello Flutter app from overlay");
  }

  Future<void> _closeOverlay() async {
    await FlutterOverlayWindow.closeOverlay();
  }

  @override
  void initState() {
    super.initState();
    _overlayListener ??= FlutterOverlayWindow.overlayListener.listen((event) {
      print("OverlayIncreaseButton Event from main Flutter app: $event");
    });
  }

  @override
  void dispose() {
    _overlayListener?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            child: CloseButton(
              onPressed: _closeOverlay,
            ),
          ),
          Center(
            child: IconButton(
              onPressed: _onPressed,
              icon: const Icon(Icons.add_circle_outlined),
            ),
          ),
        ],
      ),
    );
  }
}
