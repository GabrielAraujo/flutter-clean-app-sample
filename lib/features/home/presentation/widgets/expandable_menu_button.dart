import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

import '../../../../core/providers/viewmodel_providers.dart';
import '../models/menu_item.dart';

class ExpandableMenuButton extends StatefulWidget {
  final Function onPressed;

  ExpandableMenuButton({
    Key key,
    this.onPressed,
  }) : super(key: key);

  @override
  _ExpandableMenuButtonState createState() => _ExpandableMenuButtonState();
}

class _ExpandableMenuButtonState extends State<ExpandableMenuButton>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final homeViewModel = watch(ViewModelProviders.homeViewModel);
        List<Widget> children =
            List<Widget>.from(_buildItems(homeViewModel.menuItems));
        children.add(menuButton());
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: children,
        );
      },
    );
  }

  List<Widget> _buildItems(List<MenuItem> items) {
    return items
        .asMap()
        .map((index, value) {
          return MapEntry(
            index,
            Transform(
              transform: Matrix4.translationValues(
                0.0,
                (_translateButton.value * (index - items.length).abs()),
                0.0,
              ),
              child: _buildItem(value),
            ),
          );
        })
        .values
        .toList();
  }

  Widget _buildItem(MenuItem item) {
    return Container(
      child: Wrap(
        direction: Axis.horizontal,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 8.0,
        children: [
          Visibility(
            visible: isOpened,
            child: Text(
              item.title(context),
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          FloatingActionButton(
            heroTag: item.destination,
            onPressed: () {
              widget.onPressed(item);
            },
            child: Icon(item.icon()),
          ),
        ],
      ),
    );
  }

  Widget menuButton() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animateIcon,
        ),
      ),
    );
  }
}
