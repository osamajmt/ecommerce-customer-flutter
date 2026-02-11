import 'dart:io';

checkInternet() async {
  try {
    final response = await HttpClient()
        .getUrl(Uri.parse("http://10.0.2.2:8000"))
        .timeout(const Duration(seconds: 2));
    return true;
  } catch (_) {
    return false;
  }
}

