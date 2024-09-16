class TypeParser {
  TypeParser._();

  static DateTime? parseDateTime(String dateString) {
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      return null;
    }
  }

  static int? parseInt(String intString) {
    try {
      return int.parse(intString);
    } catch (e) {
      return null;
    }
  }
}
