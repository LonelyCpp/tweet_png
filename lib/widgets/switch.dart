import 'package:flutter/material.dart';

class CustomizeSwitch extends StatelessWidget {
  final active, onToggle, icon, label;

  const CustomizeSwitch(
      {Key key, this.active, this.onToggle, this.icon, this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return GestureDetector(
      onTap: onToggle,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: theme.primaryColorDark),
          ),
          Container(
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(13),
            decoration: BoxDecoration(
                border: Border.all(color: theme.accentColor, width: 2),
                borderRadius: BorderRadius.all((Radius.circular(33))),
                color: active ? theme.accentColor : Colors.white),
            child: Icon(
              icon,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
