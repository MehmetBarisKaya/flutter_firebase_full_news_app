import 'package:riverpod_project/product/initialize/app_cache.dart';

enum CacheSharedItems {
  token;

  String get read => AppCache.instance.sharedPreferences.getString(name) ?? '';

  Future<bool> write(String value) =>
      AppCache.instance.sharedPreferences.setString(name, value);
}
