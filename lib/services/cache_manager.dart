import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CacheManager {
  static const String _prefix = 'api_cache_';
  final Duration _defaultDuration = Duration(minutes: 5);

  Future<void> setCache(String key, dynamic data, {Duration? duration}) async {
    final prefs = await SharedPreferences.getInstance();
    final cacheData = {
      'data': data,
      'expiry': DateTime.now().add(duration ?? _defaultDuration).millisecondsSinceEpoch,
    };
    await prefs.setString('$_prefix$key', json.encode(cacheData));
  }

  Future<dynamic> getCache(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final cacheJson = prefs.getString('$_prefix$key');
    if (cacheJson != null) {
      final cacheData = json.decode(cacheJson);
      if (DateTime.now().millisecondsSinceEpoch < cacheData['expiry']) {
        return cacheData['data'];
      }
    }
    return null;
  }

  Future<void> removeCache(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('$_prefix$key');
  }

  Future<void> clearAllCache() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    for (final key in keys) {
      if (key.startsWith(_prefix)) {
        await prefs.remove(key);
      }
    }
  }
}