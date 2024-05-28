import 'package:teslo_shop/features/auth/domain/entities/user.dart';

class Product{
   String id;
   String title;
   double precio;
    String descripcion;
    String slug;
    List<String> sizes;
    String gender;
    List<String> tags;
    List<String> images;
    User? user;

   Product({
    required this.id,
    required this.title,
    required this.precio,
    required this.descripcion,
    required this.slug,
    required this.sizes, 
    required this.gender,
    required this.tags,
    required this.images,
    this.user
  });
}