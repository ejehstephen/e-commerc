import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/core/navigation/app_router.dart';
import 'package:project1/core/theme/app_theme.dart';
import 'package:project1/features/product/data/datasource/product.dart';
import 'package:project1/features/product/data/repository/product_impl.dart';
import 'package:project1/features/product/domain/repository/product_repo.dart';
import 'package:project1/features/product/presentation/Bloc/cartlist/cart_cubit.dart';
import 'package:project1/features/product/presentation/Bloc/productlist/productlist_cubit.dart';


void main() {
  // Initialize dependencies (manual DI for simplicity)
  final ProductLocalDataSource productLocalDataSource = ProductLocalDataSourceImpl();
  final ProductRepository productRepository = ProductRepositoryImpl(localDataSource: productLocalDataSource);

  runApp(MyApp(productRepository: productRepository));
}

class MyApp extends StatelessWidget {
  final ProductRepository productRepository;

  const MyApp({super.key, required this.productRepository});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: productRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ProductListCubit(
              productRepository: context.read<ProductRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => CartCubit(
              
            ), 
          ),
        ],
        child: MaterialApp.router(
          title: 'E-Commerce App',
          theme: AppTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          routerConfig: appRouter,
        ),
      ),
    );
  }
}