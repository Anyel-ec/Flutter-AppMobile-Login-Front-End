import 'package:shared_preferences/shared_preferences.dart';
import 'package:teslo_shop/features/shared/infrastructure/services/key_value_storage_service.dart';

class KeyValueStorageServiceImpl implements KeyValueStorageService {
  
  Future<SharedPreferences> getSharedPrefs() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<T?> getString<T>(String key) async{
    final prefs = await getSharedPrefs();
    // know the type of T to save it
    switch (T){

      case String:
        return prefs.getString(key) as T?;
        
      case int:
        return prefs.getInt(key) as T?;
      
      default:
        throw Exception('GET not supported ${T.runtimeType.toString()}');
    }
  }

  @override
  Future<bool> remove(String key) async{
    final prefs = await getSharedPrefs();
    return prefs.remove(key); 
  }

  @override
  Future<void> setString<T>(String key, T value) async{
    final prefs = await getSharedPrefs();
    // know the type of T to save it
    switch (T){
      case String:
        prefs.setString(key, value as String);
        break;
      case int:
        prefs.setInt(key, value as int);
        break;

      // case double:
      //   prefs.setDouble(key, value as double);
      //   break;
      // case bool:
      //   prefs.setBool(key, value as bool);
      //   break;
      default:
        throw Exception('Type not supported for ${T.runtimeType.toString()}');
    }

    
    
  }
}
