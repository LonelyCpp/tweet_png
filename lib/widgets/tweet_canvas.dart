import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:tweet_png/state/app_state.dart';
import 'package:tweet_png/widgets/tweet_data_widget.dart';

class TweetCanvas extends StatelessWidget {
  final ScreenshotController screenshotController;

  const TweetCanvas({Key key, this.screenshotController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Consumer<AppState>(
      builder: (context, appState, child) {
        return Center(
          child: Screenshot(
            controller: this.screenshotController,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Theme(
                  data:
                      appState.darkMode ? ThemeData.dark() : ThemeData.light(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: screenWidth),
                    child: _ThemedCanvas(
                      bg: appState.bgColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ThemedCanvas extends StatelessWidget {
  final Color bg;

  const _ThemedCanvas({Key key, this.bg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    ThemeData theme = Theme.of(context);

    return Container(
        width: screenWidth,
        color: bg,
        child: Center(
          child: Container(
            margin: EdgeInsets.all(32),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.all(Radius.circular(4)),
              boxShadow: [
                BoxShadow(
                  color: theme.shadowColor.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: Offset(0, 3), // changes position of shadow
                )
              ],
            ),
            child: TweetDataWidget(),
          ),
        ));
  }
}
