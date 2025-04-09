import 'package:hive/hive.dart';

const kTokenKey = 'token';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(String token);

  Future<String?> getCachedUser();

  Future<void> clearUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final Box box;

  AuthLocalDataSourceImpl(this.box);

  @override
  Future<void> cacheUser(String token) async => await box.put(kTokenKey, token);

  @override
  Future<void> clearUser() async => await box.delete(kTokenKey);

  @override
  Future<String?> getCachedUser() async => await box.get(kTokenKey);
}
