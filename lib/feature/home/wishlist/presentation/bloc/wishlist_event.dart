class WishlistEvent {}
//show wishlist
class ShowWishlistEvent extends WishlistEvent {}
//add to wishlist
class AddToWishlistEvent extends WishlistEvent{
  final int productId ;
  AddToWishlistEvent({required this.productId});
}
//remove from wishlist
class RemoveFromWishlistEvent extends WishlistEvent{
  final int productId ;
  RemoveFromWishlistEvent({required this.productId});
}