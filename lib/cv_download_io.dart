import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

const _assetPath = 'assets/cv/youssef_cv.pdf';

Future<void> downloadCvPdf() async {
  final data = await rootBundle.load(_assetPath);
  final bytes = data.buffer.asUint8List();
  final dir = await getTemporaryDirectory();
  final file = File('${dir.path}/Youssef_Hussien_Said_CV.pdf');
  await file.writeAsBytes(bytes);
  await Share.shareXFiles(
    [XFile(file.path, mimeType: 'application/pdf')],
    subject: 'CV — Youssef Hussien Said',
  );
}
