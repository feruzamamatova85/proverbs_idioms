class Prodiom {
  final PType pType;
  final PLanguage pLanguage;
  final String prodiom;
  final String explanation;
  final String equvalent;
  final String keyword;
  final String example;
  final String category;
  final bool favourite;

  Prodiom({
    this.pType,
    this.pLanguage,
    this.prodiom,
    this.explanation,
    this.equvalent,
    this.keyword,
    this.example,
    this.category,
    this.favourite,
  });

  factory Prodiom.fromJson(
      Map<String, dynamic> json, PType pType, PLanguage pLanguage) {
    return Prodiom(
      pType: pType,
      pLanguage: pLanguage,
      prodiom: pType == PType.proverb ? json['proverb'] : json['idiom'],
      explanation: json['explanation'],
      equvalent: json['equvalent'],
      keyword: json['keyword'],
      example: json['example'],
      category: json['category'],
      favourite: false,
    );
  }
}

enum PLanguage { english, uzbek }

enum PType { proverb, idiom }
