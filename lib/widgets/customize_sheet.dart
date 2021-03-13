import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tweet_png/state/app_state.dart';
import 'package:tweet_png/widgets/switch.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void showCustomizeSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) => CustomizeSheet(),
  );
}

class CustomizeSheet extends StatelessWidget {
  colorPicker(context) {
    var state = Provider.of<AppState>(context, listen: false);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: BlockPicker(
              onColorChanged: (newColor) {
                state.setBgColor = newColor;
              },
              pickerColor: state.bgColor,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Got it'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Consumer<AppState>(
        builder: (context, appState, child) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomizeSwitch(
                active: appState.showStats,
                label: 'stats',
                icon: Icons.favorite,
                onToggle: appState.toggleStats,
              ),
              CustomizeSwitch(
                active: appState.showDate,
                label: 'date',
                icon: Icons.date_range,
                onToggle: appState.toggleDate,
              ),
              CustomizeSwitch(
                active: false,
                label: 'color',
                icon: Icons.color_lens,
                onToggle: () => colorPicker(context),
              )
            ],
          );
        },
      ),
    );
  }
}
