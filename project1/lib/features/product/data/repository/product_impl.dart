import 'package:project1/features/product/data/datasource/product.dart';
import 'package:project1/features/product/domain/entities/product.dart';
import 'package:project1/features/product/domain/repository/product_repo.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDataSource localDataSource;

  ProductRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Product>> getProducts() async {
    // In a real app, you might fetch from remote and cache locally
    return localDataSource.getProducts();
  }

  @override
  Future<Product?> getProductById(String id) async {
    return localDataSource.getProductById(id);
  }
}