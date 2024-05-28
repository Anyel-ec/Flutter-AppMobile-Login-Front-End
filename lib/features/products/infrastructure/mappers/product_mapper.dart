import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/features/auth/infrastructure/mappers/user_mapper.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';

class ProductMapper {
  static jsonToEntity(Map<String, dynamic> json) => Product(
      id: json['id'],
      title: json['title'],
      precio: double.parse(json['precio'].toString()),
      descripcion: json['descripcion'],
      slug: json['slug'],
      sizes: List<String>.from(json['sizes'].map((size) => size)),
      gender: json['gender'],
      tags:List<String>.from(json['tags'].map((tag) => tag)),
      images: List<String>.from(json['images'].map(
        (String image) => image.startsWith('http') 
        ? image : '${Environment.apiUrl}/files/product/$image'
      )),
      user: UserMapper.userJsonToEntity(json['user'])
  );

}
