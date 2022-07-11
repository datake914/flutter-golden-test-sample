import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../repositories/count_repository.dart';
import 'home_page_state.dart';
import 'home_page_state_notifier.dart';

final homePageStateNotifierProvider = StateNotifierProvider<HomePageStateNotifier, HomePageState>((ref) {
  return HomePageStateNotifier(
    countRepo: CountRepository(),
  );
});
