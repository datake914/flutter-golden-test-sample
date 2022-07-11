class CountRepository {
  Future<int> get() async {
    // Simulate an API access.
    await Future.delayed(const Duration(seconds: 3));
    return 10;
  }
}
