import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smdp/pages/page_one.dart';
import 'package:smdp/circular_indicator.dart';

class ScoreUI extends StatefulWidget {
  @override
  _ScoreUIState createState() => _ScoreUIState();
}

class _ScoreUIState extends State<ScoreUI> {
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<Counter>(context);
    var score = 100 - ((counter.erCount) * 100 / counter.wordCount);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: Theme.of(context).secondaryHeaderColor

      ),
      height: MediaQuery.of(context).size.height / 5,
     child: CustomPaint(
        foregroundPainter: CircleProgress(score),
        child: Center(
          child: Text("${score.toStringAsPrecision(3)}", style: TextStyle(
            fontSize: 24,
            color: getColor(score.roundToDouble()),
            fontWeight: FontWeight.bold
          ),),
        ),
      ),
    );
  }
}
