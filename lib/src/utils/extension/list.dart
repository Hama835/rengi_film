extension ListExt on List {
  bool findById(int id) {
    if (isNotEmpty) {
      try {
        return firstWhere((element) => element.id == id) != -1;
      } catch (e) {
        return false;
      }
    } else {
      return false;
    }
  }
}
