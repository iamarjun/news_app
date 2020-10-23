class Country {
  String _name;
  String _code;
  bool _isSelected;

  String get name => _name;
  String get code => _code;
  bool get isSelected => _isSelected;
  set setSelected(value) => _isSelected = value;

  Country(
    String name,
    String code,
    bool isSelected,
  ) {
    _name = name;
    _code = code;
    _isSelected = isSelected;
  }
}
