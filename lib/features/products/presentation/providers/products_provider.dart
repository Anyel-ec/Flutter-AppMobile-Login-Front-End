import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/products/domain/entities/Product.dart';
import 'package:teslo_shop/features/products/domain/repositories/products_repository.dart';
import 'package:teslo_shop/features/products/presentation/providers/product_repository_provider.dart';


final productsProvider = StateNotifierProvider<ProductsNotifier, ProductsState>((ref) {
  
  final productsRepository = ref.watch(productsRepositoryProvider); 
  // if change the productsRepository, the provider will be updated

  return ProductsNotifier(
    productsRepository: productsRepository
  );

});



// determine when to load or next page
class ProductsNotifier extends StateNotifier<ProductsState>{
  final ProductsRepository productsRepository;
  ProductsNotifier({required this.productsRepository
  }) : super(ProductsState()){
    loadNextPage(); // load first page when the notifier is used or created
  }

  
  
  Future loadNextPage()async{

    //! IS important to check if it is loading or it is the last page
    if (state.isLoading || state.isLastPage) return; // if it is loading or it is the last page, return (do nothing

    state = state.copyWith(isLoading: true); // set isLoading to true

    final products = await productsRepository.getProductByPage(
      limit: state.limit,
      offset: state.offset
    );

    if (products.length < state.limit){ // yes it is the last page
      state = state.copyWith(isLastPage: true); // set isLastPage to true
    }

    if (products.isNotEmpty){
      state = state.copyWith(
        isLoading: false,
        isLastPage: true
      );
      return ;
    }
    state = state.copyWith(
      isLoading: false,
      isLastPage: false,
      offset: state.offset +10,
      products: [...state.products, ...products]
    );

  }
  
}

class ProductsState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<Product> products;

  ProductsState({
     this.isLastPage = false,
     this.limit = 10,
     this.offset = 0,
     this.isLoading = false,
     this.products = const []
  });

  ProductsState copyWith({
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<Product>? products
  }) {
    return ProductsState(
      isLastPage: isLastPage ?? this.isLastPage,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      isLoading: isLoading ?? this.isLoading,
      products: products ?? this.products
    );
  }
  
}