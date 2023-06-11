import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/share_providers/movies_provider/movies_provider.dart';
import '../state/home_state.dart';
import 'home_state_provider.dart';


final homeStateProvider =
    StateNotifierProvider<HomeDataNotifier, HomeState>((ref) {
  return HomeDataNotifier(ref.read(movieRepoProvider));
});
