import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:project1/core/constants/app_colors.dart';
import 'package:project1/core/utils/price_formatter.dart';
import 'package:project1/features/product/domain/entities/product.dart';
import 'package:project1/features/product/domain/repository/product_repo.dart';
import 'package:project1/features/product/presentation/Bloc/cartlist/cart_cubit.dart';

class ProductDetailPage extends StatefulWidget {
  final String productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  Product? _product;
  bool _isLoading = true;
  bool _isAddingToCart = false; // For button state
  bool _itemAdded = false; // For "Added to cart" state

  @override
  void initState() {
    super.initState();
    _fetchProductDetails();
  }

  Future<void> _fetchProductDetails() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final product = await context.read<ProductRepository>().getProductById(
        widget.productId,
      );
      if (mounted) {
        setState(() {
          _product = product;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        // Handle error, e.g., show a snackbar or navigate back
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load product: ${e.toString()}')),
        );
      }
    }
  }

  void _addToCart() {
    if (_product != null && !_itemAdded) {
      setState(() {
        _isAddingToCart = true;
      });
      context.read<CartCubit>().addProduct(_product!);
      // Simulate network delay for button state change
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() {
            _isAddingToCart = false;
            _itemAdded = true; // Item successfully added
          });
          // Show toast/snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: const [
                  Icon(Icons.check_circle, color: Colors.white),
                  SizedBox(width: 8),
                  Text('Item has been added to cart'),
                ],
              ),
              backgroundColor: AppColors.accent,
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.only(
                bottom: 70,
                left: 20,
                right: 20,
              ), // Position like toast
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              duration: const Duration(seconds: 2),
            ),
          );
          // Reset button state after a while if needed, or on navigating away
          Future.delayed(const Duration(seconds: 2), () {
            if (mounted)
              setState(() {
                _itemAdded = false;
              });
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    if (_product == null) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
        ),
        body: const Center(child: Text('Product not found')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const Text(
              "LOGO",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "DELIVERY ADDRESS",
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  "Umuahia Road, Oyo State",
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: AppColors.textPrimary),
                ),
              ],
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(
                Icons.notifications_none_outlined,
                color: AppColors.textPrimary,
              ),
              onPressed: () {},
            ),
          ],
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
      
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(thickness: 0.15,),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => context.pop(),),
                Text("Go back",style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),
              ],
            ),
            Center(
              child: Hero(
                tag:
                    'product_image_${_product!.id}', // Ensure this matches ProductCard
                child: Row(
                  children: [
                    Image.asset(
                      _product!.imageUrl,
                      height: 300,
                      fit: BoxFit.contain,
                      errorBuilder:
                          (context, error, stackTrace) =>
                              const Icon(Icons.error, size: 100),
                    ),
                    
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              _product!.name,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              PriceFormatter.format(_product!.price),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _product!.description,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed:
              _itemAdded
                  ? null
                  : _addToCart, // Disable if already added or currently adding
          style: ElevatedButton.styleFrom(
            backgroundColor:
                _itemAdded
                    ? AppColors.surface
                    : (_isAddingToCart
                        ? AppColors.primaryDark
                        : AppColors.primary),
            foregroundColor: _itemAdded ? AppColors.textDisabled : Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child:
              _isAddingToCart
                  ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    ),
                  )
                  : Text(_itemAdded ? 'Added to cart' : 'Add to cart'),
        ),
      ),
    );
  }
}
