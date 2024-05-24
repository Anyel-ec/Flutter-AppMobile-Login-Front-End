
import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/features/auth/domain/datasources/auth_datasource.dart';
import 'package:teslo_shop/features/auth/domain/entities/user.dart';
import 'package:dio/dio.dart';
import 'package:teslo_shop/features/auth/infrastructure/infrastructure.dart';


class AuthDatasourceImpl implements AuthDataSource {

  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
      
    )
  );

  @override
  Future<User> checkAuthStatus(String token) {

    throw UnimplementedError();
  }

  @override
  Future<User> login(String email, String password) async {
    try{

      final response = await dio.post('/auth/login', data: {
        'email': email,
        'password': password
      });

      final user = UserMapper.userJsonToEntity(response.data);

      return user;


    }on DioError catch(e){
      if (e.response?.statusCode == 401){
        throw WrongCredentials();
      }
      if (e.response?.statusCode == 404){
        throw UserNotFound();
      }
      if (e.type == DioErrorType.connectionTimeout){
        throw ConnectionTimeout();
      }


      throw CustomError(message: 'Something wrong happend', errorCode: 1);
    }
    catch(e){
      throw CustomError(message: 'Something wrong happend', errorCode: 1);
    }
  }

  @override
  Future<User> register(String email, String password, String fullName) {
    // TODO: implement register
    throw WrongCredentials();

  }
  

}