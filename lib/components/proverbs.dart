import 'package:flutter/material.dart';

class Proverbs extends StatefulWidget {
  @override
  _ProverbsState createState() => _ProverbsState();
}

class _ProverbsState extends State<Proverbs> {
  List<String> proverbs = [
    '	Absence makes the heart grow fonder',
    '	Actions speak louder than words.',
    'A journey of a thousand miles begins with a single step',
    'All good things must come to an end',
    'A picture is worth a thousand words',
    'A watched pot never boils',
    'Beggars can’t be choosers',
    'Beauty is in the eye of the beholder',
    'Better late than never',
    'Birds of a feather flock together',
    'Cleanliness is next to godliness',
    'Don’t bite the hand that feeds you',
    '	Don’t count your chickens before they hatch.',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Card(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              proverbs[index],
              style: TextStyle(fontSize: 20),
            ),
          ));
        },
        itemCount: proverbs.length,
      ),
    );
  }
}
