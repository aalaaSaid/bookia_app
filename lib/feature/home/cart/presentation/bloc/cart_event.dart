class CartEvent {}

//show wishlist
class ShowCartEvent extends CartEvent {}

//add to wishlist
class AddToCartEvent extends CartEvent {
  final int productId;
  AddToCartEvent({required this.productId});
}

//remove from wishlist
class RemoveFromCartEvent extends CartEvent {
  final int productId;
  RemoveFromCartEvent({required this.productId});
}

//update cart
class UpdateCartEvent extends CartEvent{
  final int productId ;
  final int quantity;

  UpdateCartEvent({required this.productId, required this.quantity});

}
//checkout
class CheckoutEvent extends CartEvent{}
