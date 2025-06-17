import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project1/core/navigation/route_name.dart';
import 'package:project1/features/product/presentation/pages/cart_page.dart';
import 'package:project1/features/product/presentation/pages/home_page.dart';
import 'package:project1/features/product/presentation/pages/product_detail.dart';
import 'package:project1/features/product/presentation/widgets/bottom_nav.dart';

// Placeholder pages for other tabs
class FavoritesPage extends StatelessWidget { const FavoritesPage({super.key}); @override Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Favorites Page'))); }
class ProfilePage extends StatelessWidget { const ProfilePage({super.key}); @override Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Profile Page'))); }


final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');
final _shellNavigatorCKey = GlobalKey<NavigatorState>(debugLabel: 'shellC');
final _shellNavigatorDKey = GlobalKey<NavigatorState>(debugLabel: 'shellD');


final GoRouter appRouter = GoRouter(
  initialLocation: RouteNames.homeShell,
  navigatorKey: _rootNavigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainScaffoldWithNav(navigationShell: navigationShell);
      },
      branches: [
        // Branch A - Home
        StatefulShellBranch(
          navigatorKey: _shellNavigatorAKey,
          routes: [
            GoRoute(
              path: RouteNames.homeShell,
              name: RouteNames.home,
              pageBuilder: (context, state) => const NoTransitionPage(child: HomePage()),
              routes: [
                 GoRoute(
                  path: 'product/:id', // Relative to homeShell
                  name: RouteNames.productDetail,
                  parentNavigatorKey: _rootNavigatorKey, // Show on top of shell
                  pageBuilder: (context, state) {
                    final productId = state.pathParameters['id']!;
                    return MaterialPage(child: ProductDetailPage(productId: productId));
                  },
                ),
              ]
            ),
          ],
        ),
        // Branch B - Cart
        StatefulShellBranch(
          navigatorKey: _shellNavigatorBKey,
          routes: [
            GoRoute(
              path: RouteNames.cartShell,
              name: RouteNames.cart,
              pageBuilder: (context, state) => const NoTransitionPage(child: CartPage()),
            ),
          ],
        ),
        // Branch C - Favorites
        StatefulShellBranch(
          navigatorKey: _shellNavigatorCKey,
          routes: [
            GoRoute(
              path: RouteNames.favoritesShell,
              name: RouteNames.favorites,
              pageBuilder: (context, state) => const NoTransitionPage(child: FavoritesPage()), // Placeholder
            ),
          ],
        ),
        // Branch D - Profile
        StatefulShellBranch(
          navigatorKey: _shellNavigatorDKey,
          routes: [
            GoRoute(
              path: RouteNames.profileShell,
              name: RouteNames.profile,
              pageBuilder: (context, state) => const NoTransitionPage(child: ProfilePage()), // Placeholder
            ),
          ],
        ),
      ],
    ),
  ],
);