abstract class KeyValueStorageService {

  Future<void> setString<T>(String key, T value); // T is Generic type
  Future<T?> getString<T>(String key);
  Future<bool> remove(String key);

}
// this class for save token JWT of user
