class StringUtils {
  static String escapeSpecial(String query) {
    return query.replaceAllMapped(RegExp(r'[.*+?^${}()|[\]\\]'), (x) {
      return '\\${x[0]}';
    });
  }

  static String capitalizeFirstLetter(String text) {
    return '${text[0].toUpperCase()}${text.substring(1).toLowerCase()}';
  }

  static String getFirstName(String name) {
    final newName = name.split(' ');
    if (newName.length > 1) {
      return newName[0];
    } else {
      return name;
    }
  }
}
