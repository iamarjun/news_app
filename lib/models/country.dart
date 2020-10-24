class Country {
  String _name;
  String _code;
  int _index;

  String get name => _name;
  String get code => _code;
  int get index => _index;
  set setIndex(value) => _index = value;

  Country(
    String name,
    String code,
    int index,
  ) {
    _name = name;
    _code = code;
    _index = index;
  }
}
