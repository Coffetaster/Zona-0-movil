import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zona0_apk/data/shared_preferences/my_shared.dart';

final mySharedProvider = Provider<MyShared>((ref) {
  return MyShared();
});