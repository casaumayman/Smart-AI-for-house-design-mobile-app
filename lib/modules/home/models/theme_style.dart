class ThemeStyle {
  static List<String> listHouseTheme = ["Royal", "Ocean", "Dark", "Romantic"];

  late final String name;
  late final int code;

  ThemeStyle._internal(this.name, this.code);

  factory ThemeStyle.fromCode(int code) {
    if (code < 0 || code >= listHouseTheme.length) {
      throw Exception("Invalid code!");
    }
    return ThemeStyle._internal(listHouseTheme[code], code);
  }

  factory ThemeStyle.fromName(String name) {
    var index = listHouseTheme.indexOf(name);
    if (index == -1) {
      throw Exception("Invalid name!");
    }
    return ThemeStyle._internal(name, index);
  }

  @override
  String toString() {
    return "name: $name, code: $code";
  }

  @override
  bool operator ==(Object other) {
    return (other.hashCode == code);
  }

  @override
  int get hashCode => code;
}
