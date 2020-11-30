import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';

import '../components/filter_list/filter_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proverbs_idioms/components/prodiom_list.dart';
import 'package:proverbs_idioms/models/prodiom.dart';
import 'package:sliver_tools/sliver_tools.dart';

import 'author_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  PLanguage currentLanguage;
  TabController controller;
  ScrollController scrollController;
  TextEditingController textEditingController;
  bool isLoading;
  bool isProberb;
  List<Prodiom> englishProverbs;
  List<Prodiom> uzbekProverbs;
  List<Prodiom> englishIdioms;
  List<Prodiom> uzbekIdioms;
  List<String> englishProverbCategories = [];
  List<String> uzbekProverbCategories = [];
  List<String> englishIdiomCategories = [];
  List<String> uzbekIdiomCategories = [];
  List<String> englishProverbSelectedCategories = [];
  List<String> uzbekProverbSelectedCategories = [];
  List<String> englishIdiomSelectedCategories = [];
  List<String> uzbekIdiomSelectedCategories = [];
  String searchPhrase;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
    scrollController = ScrollController();
    textEditingController = TextEditingController();
    textEditingController.addListener(() {
      setState(() {
        searchPhrase = textEditingController.text;
      });
    });

    currentLanguage = PLanguage.english;
    isLoading = true;
    _prepareProdioms();
    isProberb = true;
  }

  @override
  void dispose() {
    scrollController.dispose();
    controller.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  void _prepareProdioms() async {
    String jsonString = await _loadFromAsset();
    final jsonResponse = json.decode(jsonString);

    final englishProverbsResponse = jsonResponse['proverbs']['english'] as List;
    englishProverbs = englishProverbsResponse
        .map(
          (p) => Prodiom(
            pType: PType.proverb,
            pLanguage: PLanguage.english,
            category: p['category'] ?? '',
            prodiom: p['prodiom'] ?? '',
            explanation: p['explanation'] ?? '',
            equvalent: p['equivalent'] ?? '',
            example: p['example'] ?? '',
          ),
        )
        .toList();
    englishProverbs.forEach((element) {
      if (!englishProverbCategories.contains(element.category) &&
          element.category.length > 0)
        englishProverbCategories.add(element.category);
    });
    englishProverbSelectedCategories.addAll(englishProverbCategories);

    final uzbekProverbsResponse = jsonResponse['proverbs']['uzbek'] as List;
    uzbekProverbs = uzbekProverbsResponse
        .map(
          (p) => Prodiom(
            pType: PType.proverb,
            pLanguage: PLanguage.uzbek,
            category: p['category'] ?? '',
            prodiom: p['prodiom'] ?? '',
            explanation: p['explanation'] ?? '',
            equvalent: p['equivalent'] ?? '',
            example: p['example'] ?? '',
          ),
        )
        .toList();
    uzbekProverbs.forEach((element) {
      if (!uzbekProverbCategories.contains(element.category) &&
          element.category.length > 0)
        uzbekProverbCategories.add(element.category);
    });
    uzbekProverbSelectedCategories.addAll(uzbekProverbCategories);

    final englishIdiomssResponse = jsonResponse['idioms']['english'] as List;
    englishIdioms = englishIdiomssResponse
        .map(
          (p) => Prodiom(
            pType: PType.idiom,
            pLanguage: PLanguage.english,
            category: p['category'] ?? '',
            prodiom: p['prodiom'] ?? '',
            explanation: p['explanation'] ?? '',
            equvalent: p['equivalent'] ?? '',
            example: p['example'] ?? '',
          ),
        )
        .toList();
    englishIdioms.forEach((element) {
      if (!englishIdiomCategories.contains(element.category) &&
          element.category.length > 0)
        englishIdiomCategories.add(element.category);
    });
    englishIdiomSelectedCategories.addAll(englishIdiomCategories);

    final uzbekIdiomsResponse = jsonResponse['idioms']['uzbek'] as List;
    uzbekIdioms = uzbekIdiomsResponse
        .map(
          (p) => Prodiom(
            pType: PType.idiom,
            pLanguage: PLanguage.uzbek,
            category: p['category'] ?? '',
            prodiom: p['prodiom'] ?? '',
            explanation: p['explanation'] ?? '',
            equvalent: p['equivalent'] ?? '',
            example: p['example'] ?? '',
          ),
        )
        .toList();
    uzbekIdioms.forEach((element) {
      if (!uzbekIdiomCategories.contains(element.category) &&
          element.category.length > 0)
        uzbekIdiomCategories.add(element.category);
    });
    uzbekIdiomSelectedCategories.addAll(uzbekIdiomCategories);

    setState(() {
      isLoading = false;
    });
  }

  Future<String> _loadFromAsset() async {
    return await rootBundle.loadString("assets/data.json");
  }

  @override
  Widget build(BuildContext context) {
    void _openFilterDialog() async {
      List<String> allTextList = [];
      if (currentLanguage == PLanguage.english) {
        if (isProberb)
          allTextList = List.from(englishProverbCategories);
        else
          allTextList = List.from(englishIdiomCategories);
      } else {
        if (isProberb)
          allTextList = List.from(uzbekProverbCategories);
        else
          allTextList = List.from(uzbekIdiomCategories);
      }

      await FilterListDialog.display(
        context,
        applyButonTextBackgroundColor: Theme.of(context).primaryColor,
        allResetButonColor: Theme.of(context).primaryColor,
        selectedTextBackgroundColor: Theme.of(context).primaryColor,
        allTextList: allTextList,
        height: 480,
        borderRadius: 20,
        headlineText: "Select Category",
        hideSearchField: true,
        selectedTextList: currentLanguage == PLanguage.english && isProberb
            ? englishProverbSelectedCategories
            : currentLanguage == PLanguage.english && !isProberb
                ? englishIdiomSelectedCategories
                : currentLanguage == PLanguage.uzbek && isProberb
                    ? uzbekProverbSelectedCategories
                    : uzbekIdiomSelectedCategories,
        onApplyButtonClick: (list) {
          if (list != null) {
            setState(() {
              FocusScope.of(context).unfocus();
              if (currentLanguage == PLanguage.english) {
                if (isProberb)
                  englishProverbSelectedCategories = List.from(list);
                else
                  englishIdiomSelectedCategories = List.from(list);
              } else {
                if (isProberb)
                  uzbekProverbSelectedCategories = List.from(list);
                else
                  uzbekIdiomSelectedCategories = List.from(list);
              }
            });
          }
          Navigator.pop(context);
        },
      );
    }

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: DefaultTabController(
                  length: 2,
                  child: NestedScrollView(
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverOverlapAbsorber(
                            handle:
                                NestedScrollView.sliverOverlapAbsorberHandleFor(
                                    context),
                            sliver: MultiSliver(children: [
                              SliverAppBar(
                                shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(100),
                                        bottomRight: Radius.circular(100))),
                                expandedHeight: 250.0,
                                floating: true,
                                pinned: true,
                                flexibleSpace: FlexibleSpaceBar(
                                  centerTitle: true,
                                  titlePadding: EdgeInsets.all(5),
                                  title: Row(
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 40,
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.info,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AuthorScreen(),
                                                ));
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: AutoSizeText(
                                          "Paremiological Dictionary of English and Uzbek Family Traditions",
                                          maxLines: 4,
                                          style: TextStyle(
                                              shadows: [
                                                Shadow(
                                                  offset: Offset(2, 2),
                                                  blurRadius: 5,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                ),
                                              ],
                                              color: Colors.white,
                                              fontSize: 18.0,
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        height: 25,
                                        child: DropdownButton<PLanguage>(
                                          icon: Container(),
                                          value: currentLanguage,
                                          items: [
                                            DropdownMenuItem(
                                              value: PLanguage.english,
                                              child: Image.asset(
                                                'assets/images/eng-flag.png',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            DropdownMenuItem(
                                              value: PLanguage.uzbek,
                                              child: Image.asset(
                                                'assets/images/uzb-flag.png',
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          ],
                                          onTap: () {
                                            FocusScope.of(context).unfocus();
                                          },
                                          onChanged: (value) {
                                            setState(() {
                                              currentLanguage = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  background:
                                      currentLanguage == PLanguage.english
                                          ? Image.asset(
                                              'assets/images/eng-back.jpeg',
                                              fit: BoxFit.cover,
                                            )
                                          : Image.asset(
                                              'assets/images/uzb-back.JPG',
                                              fit: BoxFit.cover,
                                            ),
                                ),
                              ),
                              SliverPersistentHeader(
                                delegate: _SliverAppBarDelegate(
                                  TabBar(
                                    unselectedLabelStyle: TextStyle(
                                        fontFamily: 'Gilroy',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                    labelStyle: TextStyle(
                                        fontFamily: 'Gilroy',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                    controller: controller,
                                    onTap: (value) {
                                      FocusScope.of(context).unfocus();
                                      setState(() {
                                        if (value == 0)
                                          isProberb = true;
                                        else
                                          isProberb = false;
                                      });
                                    },
                                    labelColor: Colors.black87,
                                    unselectedLabelColor: Colors.grey,
                                    tabs: [
                                      Tab(text: 'Proverbs'),
                                      Tab(text: 'Idioms'),
                                    ],
                                  ),
                                  textEditingController,
                                  _openFilterDialog,
                                ),
                                pinned: true,
                              ),
                            ]))
                      ];
                    },
                    body: TabBarView(
                      controller: controller,
                      children: [
                        SafeArea(
                          top: false,
                          bottom: false,
                          child: Builder(
                            builder: (BuildContext context) {
                              return CustomScrollView(
                                //   controller: scrollController,
                                slivers: <Widget>[
                                  SliverOverlapInjector(
                                    handle: NestedScrollView
                                        .sliverOverlapAbsorberHandleFor(
                                            context),
                                  ),
                                  ProdiomList(
                                    categories:
                                        currentLanguage == PLanguage.english
                                            ? englishProverbSelectedCategories
                                            : uzbekProverbSelectedCategories,
                                    searchPhrase: searchPhrase ?? '',
                                    prodioms:
                                        currentLanguage == PLanguage.english
                                            ? englishProverbs
                                            : uzbekProverbs,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        SafeArea(
                          top: false,
                          bottom: false,
                          child: Builder(
                            builder: (BuildContext context) {
                              return CustomScrollView(
                                slivers: <Widget>[
                                  SliverOverlapInjector(
                                    handle: NestedScrollView
                                        .sliverOverlapAbsorberHandleFor(
                                            context),
                                  ),
                                  ProdiomList(
                                    categories:
                                        currentLanguage == PLanguage.english
                                            ? englishIdiomSelectedCategories
                                            : uzbekIdiomSelectedCategories,
                                    searchPhrase: searchPhrase ?? '',
                                    prodioms:
                                        currentLanguage == PLanguage.english
                                            ? englishIdioms
                                            : uzbekIdioms,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(
      this._tabBar, this.textEditingController, this.onFilterPressed);

  final TabBar _tabBar;
  final TextEditingController textEditingController;
  final VoidCallback onFilterPressed;

  @override
  double get minExtent => _tabBar.preferredSize.height + 100;
  @override
  double get maxExtent => _tabBar.preferredSize.height + 100;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          _tabBar,
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                      controller: textEditingController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          fontSize: 22,
                          fontFamily: 'Tantular',
                        ),
                        suffixIcon: textEditingController.text.length > 0
                            ? IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  textEditingController.text = '';

                                  FocusScope.of(context).unfocus();
                                },
                              )
                            : null,
                      )),
                ),
                FlatButton(
                  child: Row(
                    children: [
                      Icon(Icons.filter_list),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        'Filter',
                        style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'Tantular',
                        ),
                      )
                    ],
                  ),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    onFilterPressed();
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
