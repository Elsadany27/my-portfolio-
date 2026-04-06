// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use

import 'dart:html' as html;

import 'package:flutter/services.dart' show rootBundle;

const _assetPath = 'assets/cv/youssef_cv.pdf';

Future<void> downloadCvPdf() async {
  final data = await rootBundle.load(_assetPath);
  final bytes = data.buffer.asUint8List();
  final blob = html.Blob([bytes], 'application/pdf');
  final url = html.Url.createObjectUrlFromBlob(blob);
  html.AnchorElement(href: url)
    ..setAttribute('download', 'Youssef_Hussien_Said_CV.pdf')
    ..click();
  html.Url.revokeObjectUrl(url);
}
