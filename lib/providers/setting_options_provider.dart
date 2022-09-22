import 'package:flutter/foundation.dart';

class SettingOptions {
  String network;
  String password;
  double highTemp;
  double lowTemp;
  double highHumidity;
  double lowHumidity;
  int delayTime;

  SettingOptions({
    required this.network,
    required this.password,
    required this.highTemp,
    required this.lowTemp,
    required this.highHumidity,
    required this.lowHumidity,
    required this.delayTime,
  });
}

class SettingOptionsProvider with ChangeNotifier {}
