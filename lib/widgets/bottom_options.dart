import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:tweet_png/widgets/customize_sheet.dart';
import 'package:tweet_png/widgets/tweet_input_bottomsheet.dart';

class BottomOptions extends StatelessWidget {
  final ScreenshotController screenshotController;

  const BottomOptions({Key key, this.screenshotController}) : super(key: key);

  onShare() async {
    final directory = (await getApplicationDocumentsDirectory())
        .path; //from path_provide package

    String fileName = DateTime.now().microsecondsSinceEpoch.toString() + '.png';
    await screenshotController.captureAndSave(directory,
        fileName: fileName, pixelRatio: 4);

    Share.shareFiles(['$directory/$fileName']);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return BottomNavigationBar(
      backgroundColor: theme.accentColor,
      selectedItemColor: theme.textTheme.button.color,
      unselectedItemColor: theme.textTheme.button.color,
      onTap: (index) {
        switch (index) {
          case 0:
            showTweetInputSheet(context);
            break;
          case 1:
            showCustomizeSheet(context);
            break;
          case 2:
            onShare();
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.tag),
          label: 'New tweet',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.auto_awesome),
          label: 'Custumize',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.share_outlined),
          label: 'Share',
        ),
      ],
    );
  }
}
