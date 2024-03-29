import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key, required this.title});
  final String title;

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  StreamSubscription<dynamic>? _overlayListener;
  int _counter = 0;

  Future<void> _handleToggleOverlay() async {
    final isPermissionGranted =
        await FlutterOverlayWindow.isPermissionGranted();
    if (!isPermissionGranted) {
      final isGranted = await FlutterOverlayWindow.requestPermission();
      if (isGranted != true) return;
    }

    if (await FlutterOverlayWindow.isActive()) {
      await FlutterOverlayWindow.closeOverlay();
      return;
    }
    await FlutterOverlayWindow.showOverlay(
      height: 500,
      width: 500,
      flag: OverlayFlag.focusPointer,
      enableDrag: true,
    );
  }

  Future<void> _incrementCounter() async {
    final isSent =
        await FlutterOverlayWindow.shareData("Hello Overlay from Flutter side");
    print('[MainAppScreen] Is message sent: $isSent');
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    _overlayListener = FlutterOverlayWindow.overlayListener.listen((event) {
      print("[MainAppScreen] Event from overlay: $event");
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
                onPressed: _handleToggleOverlay,
                child: const Text('Toggle overlay')),
            const Text(
              'Main app counter:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
