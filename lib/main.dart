import 'package:file_uploader/pages/AmbilFile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'File Uploader',
      home: AmbilFile(),
      debugShowCheckedModeBanner: false,
    );
  }
}
