import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zona0_apk/data/datasources/api.dart';
import 'package:zona0_apk/domain/repositories/remote/remote_repository.dart';

final apiProvider = Provider<RemoteRepository>((ref) {
    return ApiConsumer();
  }
);