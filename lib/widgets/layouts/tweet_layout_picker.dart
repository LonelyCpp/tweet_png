import 'package:flutter/material.dart';
import 'tweet_layout_base.dart';
import 'tweet_layout_default.dart';
import 'tweet_layout_quote.dart';

enum TweetLayoutName { DEFAULT, QUOTE }

const names = ['default', 'quote'];

TweetLayoutBase buildTweetLayout(TweetLayoutName layoutName) {
  switch (layoutName) {
    case TweetLayoutName.QUOTE:
      return TweetLayoutQuote();

    default:
      return TweetLayoutDefault();
  }
}

class TweetLayoutPicker extends StatelessWidget {
  final onSelect;
  final layoutNames = TweetLayoutName.values;

  const TweetLayoutPicker({Key key, this.onSelect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'layouts',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: theme.primaryColorDark,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            height: 50,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: layoutNames.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => onSelect(layoutNames[index]),
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(
                        color: theme.accentColor,
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      child: Text(names[index]),
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(right: 16),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
