import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tmdb_flutter/core/network/api_constants/api_constants.dart';
import 'package:tmdb_flutter/core/repository/movies_repository.dart';
import 'package:tmdb_flutter/core/share_providers/local_db_provider/local_db_provider.dart';

import '../dio_provider/dio_client_provider.dart';

final movieRepoProvider = Provider<MoviesRepository>((ref) {
  return MoviesRepository(ref.read(dioClientProvider), ref.read(localDbProvider));
});
