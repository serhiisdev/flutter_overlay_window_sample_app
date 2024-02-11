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
  int _counter = 0;

  Future<void> _incrementCounter() async {
    await FlutterOverlayWindow.shareData("Hello Flutter app from overlay");
    setState(() {
      _counter++;
    });
  }

  Future<void> _closeOverlay() async {
    await FlutterOverlayWindow.closeOverlay();
  }

  @override
  void initState() {
    super.initState();
    _overlayListener ??= FlutterOverlayWindow.overlayListener.listen((event) {
      print("OverlayIncreaseButton Event from main Flutter app: $event");
      if (!mounted) return;
      setState(() {
        _counter += 1;
      });
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: CloseButton(
              onPressed: _closeOverlay,
            ),
          ),
          Text('Overlay counter: $_counter'),
          IconButton(
            onPressed: _incrementCounter,
            icon: const Icon(Icons.add_circle_outlined),
          ),
        ],
      ),
    );
  }
}
