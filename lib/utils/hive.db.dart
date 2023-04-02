import 'package:hive_flutter/hive_flutter.dart';

class HiveService<E> {
  Future<Box<E>> open(String name, {HiveCipher? cipher}) async {
    final box = await Hive.openBox<E>(name, encryptionCipher: cipher);
    return box;
  }

  Future<void> delete(String box) async {
    final exist = await Hive.boxExists(box);
    assert(exist, "Box doesn't exist");
    await Hive.deleteBoxFromDisk(box);
  }

  E? get({
    required String box,
    required String collection,
    E? defaultValue,
  }) {
    final isOpen = Hive.isBoxOpen(box);
    assert(isOpen, 'box $box is not opened');
    return Hive.box<E>(box).get(collection, defaultValue: defaultValue);
  }

  Future<void> put({
    required String box,
    required String collection,
    required E data,
  }) async {
    final isOpen = Hive.isBoxOpen(box);
    assert(isOpen, 'box $box is not opened');
    return Hive.box<E>(box).put(collection, data);
  }

  Future<void> dispose() async {
    await Hive.deleteFromDisk();
    await Hive.close();
  }
}
