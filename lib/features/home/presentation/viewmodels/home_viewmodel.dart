import 'package:flutter/widgets.dart';

import '../models/menu_item.dart';

class HomeViewModel extends ChangeNotifier {
  List<MenuItem> _menuItems = [
    QRCodeMenuItem(),
    ScanMenuItem(),
  ];

  List<MenuItem> get menuItems => _menuItems;
}
