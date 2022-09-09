import 'package:flutter/material.dart';
import 'package:news_app/scrren/home_page.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';


void main() => runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => MyApp(), // Wrap your app
      ),
    );
// void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Day49 API",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}