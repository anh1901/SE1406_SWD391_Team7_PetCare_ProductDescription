class FactList {
  List<Fact> factList;
  FactList({this.factList});
  factory FactList.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['facts'] as List;
    List<Fact> factList = list.map((i) => Fact.fromJson(i)).toList();
    return new FactList(
      factList: factList,
    );
  }
}

class Fact {
  final int id;
  final String fact;

  Fact({this.id, this.fact});

  factory Fact.fromJson(Map<String, dynamic> json) {
    return new Fact(
      id: json['id'] as int,
      fact: json['fact'] as String,
    );
  }
}
