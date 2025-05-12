import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preferences_service.g.dart';

@Riverpod(keepAlive: true)
SharedPreferencesService sharedPreferencesService(Ref ref) {
  return SharedPreferencesService();
}

class SharedPreferencesService {
  Future<void> setValue<T>(String key, T value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is String) {
      await prefs.setString(key, value);
    } else if (value is List<String>) {
      await prefs.setStringList(key, value);
    } else {
      throw ArgumentError('Unsupported type: ${T.runtimeType}');
    }
  }

  Future<T?> getValue<T>(String key) async {
    final prefs = await SharedPreferences.getInstance();
    dynamic value;

    if (T == int) {
      value = prefs.getInt(key);
    } else if (T == double) {
      value = prefs.getDouble(key);
    } else if (T == bool) {
      value = prefs.getBool(key);
    } else if (T == String) {
      value = prefs.getString(key);
    } else if (T == List<String>) {
      value = prefs.getStringList(key);
    } else {
      throw ArgumentError('Unsupported type: $T');
    }

    return value as T?;
  }

  Future<void> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
