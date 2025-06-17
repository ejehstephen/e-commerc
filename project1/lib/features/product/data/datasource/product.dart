import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:project1/core/constants/asset_path.dart';
import 'package:project1/features/product/data/model/product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel?> getProductById(String id);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  @override
  Future<List<ProductModel>> getProducts() async {
    final jsonString = await rootBundle.loadString(AssetPaths.productsJson);
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => ProductModel.fromJson(json)).toList();
  }

  @override
  Future<ProductModel?> getProductById(String id) async {
    final products = await getProducts();
    try {
      return products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null; 
    }
  }
}
