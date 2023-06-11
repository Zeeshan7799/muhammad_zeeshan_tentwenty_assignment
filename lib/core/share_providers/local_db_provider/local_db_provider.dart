
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tmdb_flutter/core/local_db/local_db.dart';
import 'package:tmdb_flutter/core/network/response_models/configuration_response_model.dart';

final localDbProvider = Provider<LocalDb>((ref) {
  return LocalDb();
});
