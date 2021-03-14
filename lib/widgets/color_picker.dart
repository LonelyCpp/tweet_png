import 'package:flutter/material.dart';

const List<Color> _defaultColors = [
  Colors.red,
  Colors.pink,
  Colors.purple,
  Colors.deepPurple,
  Colors.indigo,
  Colors.blue,
  Colors.lightBlue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.lightGreen,
  Colors.lime,
  Colors.yellow,
  Colors.amber,
  Colors.orange,
  Colors.deepOrange,
  Colors.brown,
  Colors.grey,
  Colors.blueGrey,
  Colors.black,
  Colors.white
];

class TweetColorPicker extends StatelessWidget {
  final onSelect;

  const TweetColorPicker({Key key, this.onSelect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'background',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: theme.primaryColorDark),
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            height: 70,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _defaultColors.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => onSelect(_defaultColors[index]),
                    child: Container(
                      width: 50,
                      color: _defaultColors[index],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
