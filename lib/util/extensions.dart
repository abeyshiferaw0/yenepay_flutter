extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');

  String clear() {
    print("newStr=> ${this.trim().toLowerCase()}");
    return this.trim().toLowerCase();
  }

  String divideAfterThreeChar() {
    String newStr = "";
    List<String> strList = [];
    for (int i = 0; i < this.length; i++) {
      if ((i % 3 == 0) & (i > 0)) {
        strList.add(' ');
      }
      strList.add(this[i]);
    }
    newStr = strList.join();
    return newStr;
  }

  String unescape() {
    String newStr = this;
    newStr = newStr.replaceAll("&lt;", "<");
    newStr = newStr.replaceAll("&gt;", ">");
    newStr = newStr.replaceAll("&amp;", "&");
    return newStr;
  }
}
