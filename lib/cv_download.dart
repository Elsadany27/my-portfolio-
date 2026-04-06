import 'cv_download_stub.dart'
    if (dart.library.html) 'cv_download_web.dart'
    if (dart.library.io) 'cv_download_io.dart';

/// Downloads the bundled PDF (browser) or opens the system share sheet (mobile/desktop).
Future<void> downloadPortfolioCv() => downloadCvPdf();
