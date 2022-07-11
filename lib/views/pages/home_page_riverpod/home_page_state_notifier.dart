import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../repositories/count_repository.dart';
import 'home_page_state.dart';

class HomePageStateNotifier extends StateNotifier<HomePageState> {
  HomePageStateNotifier({
    HomePageState state = const HomePageState(count: 0),
    required this.countRepo,
  }) : super(state);

  final CountRepository countRepo;

  Future<void> initialize() async {
    final count = await countRepo.get();
    // Set the count state.
    state = state.copyWith(count: count);
  }

  void incrementCounter() {
    state = state.copyWith(count: state.count + 1);
  }
}
