import 'package:dio/dio.dart';
import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/features/products/domain/datasources/products_datasource.dart';
import 'package:teslo_shop/features/products/domain/entities/Product.dart';
import 'package:teslo_shop/features/products/infrastructure/mappers/product_mapper.dart';

class ProductsDataSourceImpl extends ProductsDataSource {

  late final Dio dio;
  final String accessToken; // token de acceso JWT


  ProductsDataSourceImpl({required this.accessToken}): dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
      headers: {
        'Authorization': 'Bearer $accessToken'
      }
    )
  );

  @override
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike) {
    // TODO: implement createUpdateProduct
    throw UnimplementedError();
  }

  @override
  Future<Product> getProductById(String id) {
    // TODO: implement getProductById
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getProductByPage({int limit = 10, int offset = 0}) async {
    final response = await dio.get<List>('/api/products', queryParameters: {
      'limit': limit,
      'offset': offset
    });

    final List<Product> products = [];
    for (var product in response.data ?? []) {
      products.add(
        ProductMapper.jsonToEntity(product)
      );
    }

    return products;
  }

  @override
  Future<List<Product>> searchProductByTerm(String term) {
    // TODO: implement searchProductByTerm
    throw UnimplementedError();
  }
  
}