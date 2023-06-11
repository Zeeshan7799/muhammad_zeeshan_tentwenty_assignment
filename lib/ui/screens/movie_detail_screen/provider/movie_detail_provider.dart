import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_flutter/ui/screens/movie_detail_screen/state/movie_state/movie_detail_state.dart';

import '../../../../core/share_providers/movies_provider/movies_provider.dart';
import 'movie_detail_state.dart';


final movieDetailProvider =
    StateNotifierProvider<MovieDetailNotifier, MovieDetailState>((ref) {
  return MovieDetailNotifier(ref.read(movieRepoProvider));
});
