import 'package:flutter/foundation.dart';

class Items {
  String item;
  String server;

  Items({
    required this.item,
    required this.server,
  });
}

class ItemssProvider with ChangeNotifier {}
