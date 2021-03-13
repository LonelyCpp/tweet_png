import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:tweet_png/state/app_state.dart';
import 'package:tweet_png/widgets/bottom_options.dart';
import 'package:tweet_png/widgets/tweet_canvas.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => AppState(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("tweet png"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: TweetCanvas(screenshotController: screenshotController),
            ),
            BottomOptions(screenshotController: screenshotController),
          ],
        ),
      ),
    );
  }
}
