import 'package:flutter/material.dart';
import 'package:proverbs_idioms/models/prodiom.dart';
import 'package:proverbs_idioms/screens/single_prodiom_screen.dart';
import 'package:substring_highlight/substring_highlight.dart';

class ProdiomList extends StatelessWidget {
  const ProdiomList({
    Key key,
    @required this.prodioms,
    this.searchPhrase,
    this.categories,
  }) : super(key: key);

  final List<Prodiom> prodioms;
  final String searchPhrase;
  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    List<Prodiom> actalProdioms = List<Prodiom>();

    void goToPressed(int id) {
      bool isLast = actalProdioms.length - 1 == id;
      bool isFirst = id == 0;
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SingleProdiomScreen(
            id: id,
            goTo: goToPressed,
            isFirst: isFirst,
            isLast: isLast,
            prodiom: actalProdioms[id],
          ),
        ),
      );
    }

    prodioms.forEach((element) {
      if (categories.contains(element.category)) {
        if (searchPhrase.length > 0) {
          if (element.prodiom.toLowerCase().contains(
              RegExp(searchPhrase.toLowerCase(), caseSensitive: false))) {
            actalProdioms.add(element);
            return;
          }
        } else {
          actalProdioms.add(element);
        }
      }
    });

    return SliverPadding(
      padding: const EdgeInsets.all(8.0),
      sliver: actalProdioms.length == 0
          ? SliverFillRemaining(
              child: Center(
                child: Text('No results'),
              ),
            )
          : SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SingleProdiomScreen(
                                goTo: goToPressed,
                                prodiom: actalProdioms[index],
                                id: index,
                                isFirst: index == 0,
                                isLast: index == actalProdioms.length - 1,
                              ),
                            ));
                      },
                      title: SubstringHighlight(
                        text: actalProdioms[index].prodiom,
                        term: searchPhrase ?? '',
                        textStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontFamily: 'Tantular',
                        ),
                        textStyleHighlight: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontFamily: 'Tantular',
                            fontSize: 20),
                      ),
                    ),
                  );
                },
                childCount: actalProdioms.length,
              ),
            ),
    );
  }
}
