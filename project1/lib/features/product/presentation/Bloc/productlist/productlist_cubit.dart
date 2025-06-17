import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project1/features/product/domain/entities/product.dart';
import 'package:project1/features/product/domain/repository/product_repo.dart';

part 'productlist_state.dart';

class ProductListCubit extends Cubit<ProductListState> {
  final ProductRepository productRepository;

  ProductListCubit({required this.productRepository})
    : super(ProductListInitial());

  Future<void> fetchProducts() async {
    try {
      emit(ProductListLoading());
      final products = await productRepository.getProducts();
      emit(ProductListLoaded(products));
    } catch (e) {
      emit(ProductListError(e.toString()));
    }
  }
}