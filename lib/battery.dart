import 'dart:async';

import 'package:flutter/services.dart';

class Battery {
  static const MethodChannel _channel = const MethodChannel('battery');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> get batteryLevel async {
    String batteryLevel;
    try {
      final int result = await _channel.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } catch (e) {
      batteryLevel = "Failed to get battery level: '$e'.";
    }
    return batteryLevel;
  }
}
