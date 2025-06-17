part of 'cart_cubit.dart';

class CartState extends Equatable {
  final List<CartItem> items;
  final bool itemAddedSuccessfully;
  final int uniqueItemsCount;
  final String? error;

  const CartState({
    this.items = const [],
    this.itemAddedSuccessfully = false,
    this.uniqueItemsCount = 0,
    this.error,
  });

  CartState copyWith({
    List<CartItem>? items,
    bool? itemAddedSuccessfully,
    int? uniqueItemsCount,
    String? error,
  }) {
    return CartState(
      items: items ?? this.items,
      itemAddedSuccessfully: itemAddedSuccessfully ?? this.itemAddedSuccessfully,
      uniqueItemsCount: uniqueItemsCount ?? this.uniqueItemsCount,
      error: error ?? this.error,
    );
  }

  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);
  double get subtotalPrice => items.fold(0.0, (sum, item) => sum + item.totalPrice);
  double get shippingPrice => items.isEmpty ? 0.0 : 10.0;
  double get totalPrice => subtotalPrice + shippingPrice;

  @override
  List<Object?> get props => [items, itemAddedSuccessfully, uniqueItemsCount, error];
}