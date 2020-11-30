import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:proverbs_idioms/models/prodiom.dart';
import 'package:sliver_tools/sliver_tools.dart';

class AuthorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: MultiSliver(
                    children: [
                      SliverAppBar(
                        leading: Container(),
                        shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(100),
                                bottomRight: Radius.circular(100))),
                        expandedHeight: 400.0,
                        collapsedHeight: 100,
                        floating: true,
                        pinned: true,
                        flexibleSpace: LayoutBuilder(
                          builder: (BuildContext context,
                              BoxConstraints constraints) {
                            return FlexibleSpaceBar(
                              background: constraints.biggest.height < 200
                                  ? Container(
                                      color: Theme.of(context).primaryColor,
                                    )
                                  : Hero(
                                      tag: 'author',
                                      child: Image.asset(
                                        'assets/images/author.JPG',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                              titlePadding: EdgeInsets.all(30),
                              title: constraints.biggest.height < 200
                                  ? Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (constraints.biggest.height <= 120)
                                          IconButton(
                                              icon: Icon(Icons.arrow_back),
                                              color: Colors.white,
                                              onPressed: () =>
                                                  Navigator.pop(context)),
                                        Hero(
                                          tag: 'author',
                                          child: ClipOval(
                                            child: Image.asset(
                                                'assets/images/author.JPG'),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: AutoSizeText(
                                            'Feruza Makhammadovna Mamatova',
                                            maxLines: 3,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                              fontFamily: 'MovaviGrotesque',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : AutoSizeText(
                                      'Feruza Makhammadovna Mamatova',
                                      maxLines: 3,
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 25.0,
                                        fontFamily: 'MovaviGrotesque',
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          Shadow(
                                            offset: Offset(2, 2),
                                            blurRadius: 5,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                          ),
                                        ],
                                      ),
                                    ),
                            );
                          },
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
                            onTap: (value) {},
                            labelColor: Colors.black87,
                            unselectedLabelColor: Colors.grey,
                            tabs: [
                              Tab(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 30,
                                      child: Image.asset(
                                        'assets/images/eng-flag.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text('ENG')
                                  ],
                                ),
                              ),
                              Tab(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 30,
                                      child: Image.asset(
                                        'assets/images/uzb-flag.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text('UZB')
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        pinned: true,
                      ),
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                SafeArea(
                  top: false,
                  bottom: false,
                  child: Builder(
                    builder: (context) => CustomScrollView(
                      slivers: [
                        SliverOverlapInjector(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context),
                        ),
                        SliverPadding(
                          padding: EdgeInsets.all(10),
                          sliver: SliverToBoxAdapter(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              margin: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 5),
                              elevation: 5,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 15, 10, 5),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'About the author and the dictionary',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Feruza Mamatova is a Phd researcher in  linguoculturology, sociolinguistics and psycholinguistics at the National University of Uzbekistan. She is an ESL, EFL teacher, translator and a specialist in the paremiology of the English and Uzbek languages. In the scope of these fields she has published more than 20 works. The author has  held a linguoculturological, sociolinguistic and psycholinguistic research based on the English and Uzbek proverbs and idioms related to family traditions among English and Uzbek speakers and the same proverbs and idioms are  used in the compilation of the “Paremiological dictionary of English and Uzbek family traditions”. The dictionary  consists of four parts: English proverbs, Uzbek proverbs, English idioms and Uzbek idioms. In proverbs section explanations and equivalents (if exist) are provided. In the idioms section besides equivalents and explanations,  examples are provided to give clearer understanding. Inserting key words in the “search field”  of the application one can find desired proverbs. The dictionary is a good tool  for students, translators, teachers, tutors, researchers, scientists in linguistics. In addition, it may serve as a useful application for learners who is interested in cross-cultural studies, since it allows to penetrate to the English and Uzbek Family traditions.',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SafeArea(
                  top: false,
                  bottom: false,
                  child: Builder(
                    builder: (context) => CustomScrollView(
                      slivers: [
                        SliverOverlapInjector(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context),
                        ),
                        SliverPadding(
                          padding: EdgeInsets.all(10),
                          sliver: SliverToBoxAdapter(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              margin: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 5),
                              elevation: 5,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 15, 10, 5),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Муаллиф ва луғат ҳақида',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Феруза Маматова инглиз тили ўқитувчиси, таржимон,  инглиз ва ўзбек мақоллари бўйича мутаҳасис  ҳамда Ўзбекистон Миллий Университетида лингвомаданиятшунослик, социолингвистика ва психолингвистика бўйича тадқиқот олиб бораётган мустақил изланувчи.  Тилшуносликнинг ушбу йўналишлари бўйича муаллифнинг 20 дан ортиқ илмий ишлари эьлон қилинган. Муаллиф диссертация иши таркибига кирувчи инглиз ва ўзбек тилларида сўзлашувчилар орасида олиб борилган лингвомаданий,  социолингвистик ва психолингвистик тадқиқот олиб борган ва тадқиқотда фойдаланилган мақол ва иборалар “Paremiological dictionary of English and Uzbek Family traditions” луғатида ўрин олди. Ушбу луғат тўрт қисмдан иборат: инглиз ва ўзбек мақоллари ҳамда инглиз ва ўзбек тилларидаги иборалар. Мақоллар бўлимида изоҳ ва (агар мавжуд бўлса) иккинчи тилда муқобиллар берилган, иборалар(идиомалар) қисмида изоҳ ва муқобиллардан ташқари, ибораларни яҳшироқ тушунтириш мақсадида уларнинг ишлатилиши бўйича намуналар берилган. Илованинг “қидирув жойи”га калит сўзларни киритиш орқали керакли мақолни топиш мумкин. Луғат  тилшунослик соҳасидаги талабалар, таржимонлар, ўқитувчилар, тадқиқотчилар, олимларга яҳши манбадир. Қолаверса, маданиятлараро мулоқотни ўрганиш  масалаларига қизиқувчиларга фойдали мобил илова бўлиб ҳизмат қилади, чунки у инглиз ва ўзбек оилавий аньаналари билан танишиш имконини беради.',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(
    this._tabBar,
  );

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 500,
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
