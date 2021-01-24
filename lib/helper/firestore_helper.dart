class FirestoreHelper {
  static String getCollectionPath(List<String> elements) {
    return elements.join('/');
  }
}
