import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:superformula/features/home/presentation/models/menu_item.dart';
import 'package:superformula/features/home/presentation/widgets/expandable_menu_button.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).homeTitle),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Container(),
      ),
      floatingActionButton: ExpandableMenuButton(
        onPressed: tappedMenuItem,
      ),
    );
  }

  void tappedMenuItem(MenuItem item) {
    Navigator.pushNamed(
      context,
      item.destination,
    );
  }
}
