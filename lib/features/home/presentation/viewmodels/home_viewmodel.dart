import 'package:flutter/widgets.dart';
import 'package:superformula/features/home/presentation/models/menu_item.dart';

class HomeViewModel extends ChangeNotifier {
  List<MenuItem> _menuItems = [
    QRCodeMenuItem(),
    ScanMenuItem(),
  ];

  List<MenuItem> get menuItems => _menuItems;
}
