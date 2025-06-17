import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project1/core/constants/app_colors.dart';
import 'package:project1/core/constants/asset_path.dart';
import 'package:project1/core/utils/price_formatter.dart';
import 'package:project1/features/product/domain/entities/carti_tem.dart';
import 'package:project1/features/product/presentation/Bloc/cartlist/cart_cubit.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const CartItemWidget({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.read<CartCubit>();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: AppColors.success,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            const SizedBox(width: 12),
            Image.asset(
              cartItem.product.imageUrl,
              width: 90,
              height: 90,
              fit: BoxFit.cover,
              errorBuilder:
                  (context, error, stackTrace) =>
                      const Icon(Icons.error, size: 40),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.product.name,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 9),
                  Text(
                    PriceFormatter.format(cartItem.product.price),
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    "In stock",
                    style: TextStyle(
                      color: AppColors.accent,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                   const SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                         decoration: BoxDecoration(
                          color: AppColors.grey,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: IconButton(
                          icon: SvgPicture.asset(
                            AssetPaths.iconMinus,
                            color: AppColors.textSecondary,
                            width: 19,
                            height: 19,
                          ),
                          onPressed:
                              () => cartCubit.decrementQuantity(
                                cartItem.product.id,
                              ),
                          constraints: const BoxConstraints(),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                       const SizedBox(width: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          cartItem.quantity.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                       const SizedBox(width: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: IconButton(
                          icon: SvgPicture.asset(
                            AssetPaths.iconPlus,
                            
                            width: 19,
                            height: 19,
                          ),
                          onPressed:
                              () => cartCubit.incrementQuantity(
                                cartItem.product.id,
                              ),
                          constraints: const BoxConstraints(),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                      const Spacer(),

                      IconButton(
                        icon: SvgPicture.asset(
                          AssetPaths.iconTrash,
                          color: AppColors.error,
                          width: 24,
                          height: 24,
                        ),
                        onPressed:
                            () => cartCubit.removeProduct(cartItem.product.id),
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
