import 'package:flutter/material.dart';
import 'package:flutter_overlay_window_sample_app/src/main_app_screen.dart';
import 'package:flutter_overlay_window_sample_app/src/overlay_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainAppScreen(title: 'Overlay Test'),
    ),
  );
}

@pragma("vm:entry-point")
void overlayMain() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OverlayScreen(),
    ),
  );
}
