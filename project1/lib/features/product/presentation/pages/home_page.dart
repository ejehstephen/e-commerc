import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/core/constants/app_colors.dart';
import 'package:project1/features/product/presentation/Bloc/productlist/productlist_cubit.dart';
import 'package:project1/features/product/presentation/widgets/product_card.dart';
// import 'package:ecommerce_app/features/product/presentation/widgets/custom_app_bar.dart'; // You'd create this

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductListCubit>().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const Text("LOGO", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("DELIVERY ADDRESS", style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.textSecondary)),
                Text("Umuahia Road, Oyo State", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textPrimary)),
              ],
            ),
            const Spacer(),
            IconButton(icon: const Icon(Icons.notifications_none_outlined, color: AppColors.textPrimary), onPressed: () {}),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppColors.border),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppColors.border),
                    ),
                    filled: true,
                    fillColor: AppColors.success,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             const Divider(thickness: 0.15,),
             const SizedBox(height: 5),
                  Row(
                    children: [
                       IconButton(onPressed: (){},icon: Icon(Icons.arrow_back)),
                      Text("Technology", style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold,fontSize: 18)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text("Smartphones, Laptops & \n Asseccories", style: TextStyle(
                      fontSize: 22,
                      color: AppColors.textPrimary.withOpacity(0.7),fontWeight: FontWeight.bold)),
                  ),
            
            BlocBuilder<ProductListCubit, ProductListState>(
              builder: (context, state) {
                if (state is ProductListLoading || state is ProductListInitial) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is ProductListLoaded) {
                  return Container(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.7, // 70% of screen height
                    ),
                    child: GridView.builder(
                      shrinkWrap: true,
                      // physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(16.0),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.65,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        return ProductCard(product: state.products[index]);
                      },
                    ),
                  );
                }
                if (state is ProductListError) {
                  return Center(child: Text('Error: ${state.message}'));
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}