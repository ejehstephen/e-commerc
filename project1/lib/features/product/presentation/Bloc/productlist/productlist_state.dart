

part of 'package:project1/features/product/presentation/Bloc/productlist/productlist_cubit.dart';



abstract class ProductListState extends Equatable {
  const ProductListState();

  @override
  List<Object?> get props => [];
}

class ProductListInitial extends ProductListState {
  const ProductListInitial();
}

class ProductListLoading extends ProductListState {
   const ProductListLoading();
}

class ProductListLoaded extends ProductListState {
  final List<Product> products;

  const ProductListLoaded(this.products);

  @override
  List<Object> get props => [products];
}

class ProductListError extends ProductListState {
  final String message;

  const ProductListError(this.message);

  @override
  List<Object> get props => [message];
}
