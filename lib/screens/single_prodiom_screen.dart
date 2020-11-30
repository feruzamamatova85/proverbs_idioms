import 'package:flutter/material.dart';
import 'package:proverbs_idioms/models/prodiom.dart';

class SingleProdiomScreen extends StatelessWidget {
  final Prodiom prodiom;
  final int id;
  final Function goTo;
  final bool isFirst;
  final bool isLast;

  const SingleProdiomScreen({
    Key key,
    this.prodiom,
    this.id,
    this.goTo,
    this.isFirst,
    this.isLast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> sliverList = [
      if (prodiom.explanation.length > 0)
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (prodiom.pLanguage == PLanguage.english)
                Text(
                  'Uzbek explanation',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              if (prodiom.pLanguage == PLanguage.uzbek)
                Text(
                  'English explanation',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              SizedBox(height: 10),
              Text(
                prodiom.explanation,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      if (prodiom.equvalent.length > 0)
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (prodiom.pLanguage == PLanguage.english)
                Text(
                  'Uzbek equivalent',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              if (prodiom.pLanguage == PLanguage.uzbek)
                Text(
                  'English equivalent',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              SizedBox(height: 10),
              Text(
                prodiom.equvalent,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      if (prodiom.example.length > 0)
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (prodiom.pLanguage == PLanguage.english)
                Text(
                  'English example',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              if (prodiom.pLanguage == PLanguage.uzbek)
                Text(
                  'English example',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              SizedBox(height: 10),
              Text(
                prodiom.example,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        )
    ];

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        child: Row(
          mainAxisAlignment: isFirst
              ? MainAxisAlignment.end
              : isLast
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.spaceBetween,
          children: [
            if (!isFirst)
              RaisedButton(
                onPressed: () {
                  goTo(id - 1);
                },
                child: Icon(Icons.arrow_back),
              ),
            if (!isLast)
              RaisedButton(
                onPressed: () {
                  goTo(id + 1);
                },
                child: Icon(Icons.arrow_forward),
              ),
          ],
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(100),
                        bottomRight: Radius.circular(100))),
                expandedHeight: 200.0,
                floating: true,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  //        centerTitle: true,
                  titlePadding: EdgeInsets.all(30),
                  title: Text(prodiom.prodiom,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontFamily: 'MovaviGrotesque',
                        fontWeight: FontWeight.bold,
                      )),
                )),
            SliverPadding(
              padding: EdgeInsets.all(10),
              sliver: SliverToBoxAdapter(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  margin: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: sliverList,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
