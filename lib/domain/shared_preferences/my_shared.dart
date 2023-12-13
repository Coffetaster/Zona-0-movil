import 'package:shared_preferences/shared_preferences.dart';

part 'my_shared_constants.dart';

class MyShared {
  Future<SharedPreferences> getSharedPrefs() async {
    return await SharedPreferences.getInstance();
  }

  Future<T?> getValue<T>(String key, [T? defaultValue]) async {
    final prefs = await getSharedPrefs();

    switch (T) {
      case int:
        return (prefs.getInt(key) as T?) ?? defaultValue;
      case bool:
        return (prefs.getBool(key) as T?) ?? defaultValue;
      case double:
        return (prefs.getDouble(key) as T?) ?? defaultValue;
      case String:
        return (prefs.getString(key) as T?) ?? defaultValue;
      default:
        throw UnimplementedError(
            'GET not implemented for type ${T.runtimeType}');
    }
  }

  Future<T> getValueNoNull<T>(String key, [T? defaultValue]) async {
    switch (T) {
      case int:
        return (await getValue(key, defaultValue)) ?? 0 as T;
      case bool:
        return (await getValue(key, defaultValue)) ?? false as T;
      case double:
        return (await getValue(key, defaultValue)) ?? 0 as T;
      case String:
        return (await getValue(key, defaultValue)) ?? "" as T;
      default:
        throw UnimplementedError(
            'GET not implemented for type ${T.runtimeType}');
    }
  }

  Future<bool> removeKey(String key) async {
    final prefs = await getSharedPrefs();
    return await prefs.remove(key);
  }

  Future<void> setKeyValue<T>(String key, T value) async {
    final prefs = await getSharedPrefs();
    switch (T) {
      case int:
        prefs.setInt(key, value as int);
        break;
      case bool:
        prefs.setBool(key, value as bool);
        break;
      case double:
        prefs.setDouble(key, value as double);
        break;
      case String:
        prefs.setString(key, value as String);
        break;
      default:
        throw UnimplementedError(
            'Set not implemented for type ${T.runtimeType}');
    }
  }
}

/*
// Obtain shared preferences.
final SharedPreferences prefs = await SharedPreferences.getInstance();

// Save an integer value to 'counter' key.
await prefs.setInt('counter', 10);
// Save an boolean value to 'repeat' key.
await prefs.setBool('repeat', true);
// Save an double value to 'decimal' key.
await prefs.setDouble('decimal', 1.5);
// Save an String value to 'action' key.
await prefs.setString('action', 'Start');
// Save an list of strings to 'items' key.
await prefs.setStringList('items', <String>['Earth', 'Moon', 'Sun']);

// Try reading data from the 'counter' key. If it doesn't exist, returns null.
final int? counter = prefs.getInt('counter');
// Try reading data from the 'repeat' key. If it doesn't exist, returns null.
final bool? repeat = prefs.getBool('repeat');
// Try reading data from the 'decimal' key. If it doesn't exist, returns null.
final double? decimal = prefs.getDouble('decimal');
// Try reading data from the 'action' key. If it doesn't exist, returns null.
final String? action = prefs.getString('action');
// Try reading data from the 'items' key. If it doesn't exist, returns null.
final List<String>? items = prefs.getStringList('items');
*/
