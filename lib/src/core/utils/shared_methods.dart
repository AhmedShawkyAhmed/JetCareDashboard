import 'dart:io';

import 'package:flutter/foundation.dart';

void printSuccess(Object? object, {Type? runtimeType}) {
  String line = "${object?.toString()}";
  String? className;
  if (runtimeType != null) {
    className = "\x1B[1;4;32m${runtimeType.toString()}:\x1B[0m";
  }
  if (kDebugMode) {
    if (Platform.isIOS) {
      if (runtimeType != null) className = "${runtimeType.toString()}:";
      debugPrint('${className ?? ''} $line');
    } else {
      debugPrint('${className ?? ''} \x1B[32m$line\x1B[0m');
    }
  }
}

void printError(Object? object, {Type? runtimeType}) {
  String line = "${object?.toString()}";
  String? className;
  if (runtimeType != null) {
    className = "\x1B[1;4;31m${runtimeType.toString()}:\x1B[0m";
  }
  if (kDebugMode) {
    if (Platform.isIOS) {
      if (runtimeType != null) className = "${runtimeType.toString()}:";
      debugPrint('${className ?? ''} $line');
    } else {
      debugPrint('${className ?? ''} \x1B[31m$line\x1B[0m');
    }
  }
}

void printLog(Object? object, {Type? runtimeType}) {
  String line = "${object?.toString()}";
  String? className;
  if (runtimeType != null) {
    className = "\x1B[1;34m${runtimeType.toString()}:\x1B[0m";
  }
  if (kDebugMode) {
    if (Platform.isIOS) {
      if (runtimeType != null) className = "${runtimeType.toString()}:";
      debugPrint('${className ?? ''} $line');
    } else {
      debugPrint('${className ?? ''} \x1B[34m$line\x1B[0m');
    }
  }
}

void printResponse(Object? object) {
  String line = "$object";
  if (kDebugMode) {
    if (Platform.isIOS) {
      debugPrint(line);
    } else {
      debugPrint('\x1B[33m$line\x1B[0m');
    }
  }
}

void printRequest(Object? object) {
  String line = "$object";
  if (kDebugMode) {
    if (Platform.isIOS) {
      debugPrint(line);
    } else {
      debugPrint('\x1B[35m$line\x1B[0m');
    }
  }
}

// Future<void> openUrl(String url) async {
//   if (!await launchUrl(Uri.parse(url))) {
//     throw Exception('Could not launch $url');
//   }
// }

// bool isArabic = CacheService.get(key: CacheKeys.language) == Languages.ar.name;
