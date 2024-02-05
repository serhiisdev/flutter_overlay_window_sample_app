import 'package:flutter/material.dart';
import 'package:flutter_overlay_window_sample_app/src/my_home_page.dart';
import 'package:flutter_overlay_window_sample_app/src/overlay_increase_button.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Overlay Test'),
    ),
  );
}

@pragma("vm:entry-point")
void overlayMain() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OverlayIncreaseButton(),
    ),
  );
}
