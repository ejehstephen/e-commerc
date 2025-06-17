import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:badges/badges.dart' as badges;
import 'package:project1/core/constants/app_colors.dart';
import 'package:project1/features/product/presentation/Bloc/cartlist/cart_cubit.dart';

class MainScaffoldWithNav extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainScaffoldWithNav({super.key, required this.navigationShell});

  void _onItemTapped(int index, BuildContext context) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => _onItemTapped(index, context),
        type: BottomNavigationBarType.fixed, 
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, color: AppColors.textSecondary),
            activeIcon: Icon(Icons.home, color: AppColors.primary),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                return badges.Badge(
                  showBadge: state.totalItems > 0,
                  badgeContent: Text(
                    state.totalItems.toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                  badgeStyle: const badges.BadgeStyle(
                    badgeColor: AppColors.primary,
                  ),
                  position: badges.BadgePosition.topEnd(top: -8, end: -8),
                  child: Icon(Icons.shopping_cart_outlined, color: AppColors.textSecondary),
                );
              },
            ),
            activeIcon: BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                return badges.Badge(
                  showBadge: state.totalItems > 0,
                  badgeContent: Text(
                    state.totalItems.toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                  badgeStyle: const badges.BadgeStyle(
                    badgeColor: AppColors.primary,
                  ),
                  position: badges.BadgePosition.topEnd(top: -8, end: -8),
                  child: Icon(Icons.shopping_cart, color: AppColors.primary),
                );
              },
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border, color: AppColors.textSecondary),
            activeIcon: Icon(Icons.favorite, color: AppColors.primary),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline, color: AppColors.textSecondary),
            activeIcon: Icon(Icons.person, color: AppColors.primary),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}