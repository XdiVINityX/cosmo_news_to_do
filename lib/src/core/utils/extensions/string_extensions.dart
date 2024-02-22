extension StringExtensions on String {
  String get removedLast => isEmpty ? this : substring(0, length - 1);
}
