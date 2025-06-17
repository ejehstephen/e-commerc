
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/core/constants/app_colors.dart';
import 'package:project1/core/utils/price_formatter.dart';
import 'package:project1/features/product/presentation/Bloc/cartlist/cart_cubit.dart';
import 'package:project1/features/product/presentation/widgets/card_item.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return const Center(
              child: Text('Your cart is empty.', style: TextStyle(fontSize: 18, color: AppColors.textSecondary)),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,  
            children: [
               const Divider(thickness: 0.15,),
              Row(
                children: [
                  
                  IconButton(onPressed: (){},icon: Icon(Icons.arrow_back)),
                  const Text('Your Cart', style: TextStyle(color: AppColors.textPrimary, 
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: state.items.length,
                  itemBuilder: (context, index) {
                    return CartItemWidget(cartItem: state.items[index]);
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                    ),
                  ],
                  
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text("Order Info", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Subtotal:', style: TextStyle(fontSize: 16, color: AppColors.textSecondary,fontWeight: FontWeight.bold,)),
                        Text(PriceFormatter.format(state.subtotalPrice), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Shipping:', style: TextStyle(fontSize: 16, color: AppColors.textSecondary,fontWeight: FontWeight.bold,)),
                        Text(PriceFormatter.format(state.shippingPrice), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                        Text(PriceFormatter.format(state.totalPrice), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Handle checkout
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Checkout not implemented yet!')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text('Checkout (${PriceFormatter.format(state.totalPrice)})'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}