import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project1/features/product/domain/entities/carti_tem.dart';
import 'package:project1/features/product/domain/entities/product.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState());

  void addProduct(Product product) {
    final List<CartItem> updatedItems = List.from(state.items);
    final itemIndex = updatedItems.indexWhere((item) => item.product.id == product.id);

    if (itemIndex != -1) {
      // Product already in cart, increase quantity
      final existingItem = updatedItems[itemIndex];
      updatedItems[itemIndex] = existingItem.copyWith(quantity: existingItem.quantity + 1);
      emit(state.copyWith(items: updatedItems));
    } else {
      // Add new product to cart
      updatedItems.add(CartItem(product: product, quantity: 1));
      // Increment badge count only when new item is added
      emit(state.copyWith(
        items: updatedItems,
        itemAddedSuccessfully: true,
        cartBadgeCount: state.cartBadgeCount + 1,
      ));
    }
    // Reset flag after a short delay or when consumed by UI
    Future.delayed(const Duration(milliseconds: 100), () => emit(state.copyWith(itemAddedSuccessfully: false)));
  }

  void removeProduct(String productId) {
    final List<CartItem> updatedItems = List.from(state.items);
    updatedItems.removeWhere((item) => item.product.id == productId);
    emit(state.copyWith(
      items: updatedItems,
      cartBadgeCount: state.cartBadgeCount - 1,
    ));
  }

  void incrementQuantity(String productId) {
    final List<CartItem> updatedItems = List.from(state.items);
    final itemIndex = updatedItems.indexWhere((item) => item.product.id == productId);
    if (itemIndex != -1) {
      final existingItem = updatedItems[itemIndex];
      updatedItems[itemIndex] = existingItem.copyWith(quantity: existingItem.quantity + 1);
      emit(state.copyWith(items: updatedItems));
    }
  }

  void decrementQuantity(String productId) {
    final List<CartItem> updatedItems = List.from(state.items);
    final itemIndex = updatedItems.indexWhere((item) => item.product.id == productId);
    if (itemIndex != -1) {
      final existingItem = updatedItems[itemIndex];
      if (existingItem.quantity > 1) {
        updatedItems[itemIndex] = existingItem.copyWith(quantity: existingItem.quantity - 1);
        emit(state.copyWith(items: updatedItems));
      } else {
        // Remove if quantity becomes 0 or less
        updatedItems.removeAt(itemIndex);
        emit(state.copyWith(
          items: updatedItems,
          cartBadgeCount: state.cartBadgeCount - 1,
        ));
      }
    }
  }
}