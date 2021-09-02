import 'package:localstorage/localstorage.dart';

class JsonStorageService {
  late final LocalStorage storage;

  JsonStorageService(String name) {
    storage = LocalStorage('$name.json');
  }

  Future<void> set(String key, Object value) async {
    await storage.ready;
    await storage.setItem(key, value);
  }

  Future get(String key) async {
    await storage.ready;
    var value = await storage.getItem(key);
    return value;
  }
}
