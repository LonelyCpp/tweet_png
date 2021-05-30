import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tweet_png/state/app_state.dart';
import 'package:tweet_png/widgets/color_picker.dart';
import 'package:tweet_png/widgets/layouts/tweet_layout_picker.dart';
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
    var theme = Theme.of(context);

    return Container(
      color: Colors.black12,
      padding: EdgeInsets.all(16),
      child: Consumer<AppState>(
        builder: (context, appState, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomizeSwitch(
                      active: appState.darkMode,
                      label: 'theme',
                      icon: Icons.settings_brightness,
                      onToggle: appState.toggleDarkMode,
                    ),
                    CustomizeSwitch(
                      active: appState.showLikes,
                      label: 'likes',
                      icon: Icons.favorite,
                      onToggle: appState.toggleLikes,
                    ),
                    CustomizeSwitch(
                      active: appState.showRetweets,
                      label: 'retweets',
                      icon: Icons.repeat_rounded,
                      onToggle: appState.toggleRetweets,
                    ),
                    CustomizeSwitch(
                      active: appState.showReplies,
                      label: 'replies',
                      icon: Icons.mode_comment_outlined,
                      onToggle: appState.toggleReplies,
                    ),
                    CustomizeSwitch(
                      active: appState.showStats,
                      label: 'stats',
                      icon: Icons.insights,
                      onToggle: appState.toggleStats,
                    ),
                    CustomizeSwitch(
                      active: appState.showDate,
                      label: 'date',
                      icon: Icons.date_range,
                      onToggle: appState.toggleDate,
                    ),
                  ],
                ),
              ),
              Consumer<AppState>(
                builder: (context, appState, child) {
                  return TweetColorPicker(
                    onSelect: (newColor) {
                      appState.setBgColor = newColor;
                    },
                  );
                },
              ),
              Consumer<AppState>(
                builder: (context, appState, child) {
                  return TweetLayoutPicker(
                    onSelect: (newLayout) {
                      appState.setLayout = newLayout;
                    },
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
