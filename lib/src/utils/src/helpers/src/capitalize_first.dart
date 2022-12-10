extension StringExtension on String {
  String get capitalizeFirst {
    if (this.isNotEmpty) {
      return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
    }
    return this;
  }
}
