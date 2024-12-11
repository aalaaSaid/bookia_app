import 'package:booki_app/feature/home/cart/data/models/cart_model.dart';
import 'package:booki_app/feature/home/cart/data/repo/cart_repo.dart';
import 'package:booki_app/feature/home/cart/presentation/bloc/cart_event.dart';
import 'package:booki_app/feature/home/cart/presentation/bloc/cart_state.dart';
import 'package:booki_app/feature/home/profile/data/models/profile_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(InitialCartState()) {
    on<ShowCartEvent>(showCart);
    on<AddToCartEvent>(addToCart);
    on<RemoveFromCartEvent>(removeFromCart);
    on<UpdateCartEvent>(updateCart);
    on<CheckoutEvent>(getCheckout);
  }
  ProfileModel? profileModel;
  CartModel? cartModel;
  Future<void>getCheckout(CheckoutEvent event,Emitter<CartState>emit)async{
    emit(CheckoutLoadingState());
    await CartRepo.getCheckout().then((value){
      if(value!=null){
        profileModel= value ;
        emit(CheckoutSuccessState());
      }else{
        emit(CheckoutErrorState());
      }
    });
  }
  //show cart
  Future<void> showCart(ShowCartEvent event, Emitter<CartState> emit) async {
    emit(ShowCartLoadingState());
    await CartRepo.getCart().then((value) {
      if (value != null) {
        cartModel = value;
        emit(ShowCartSuccessState());
      } else {
        emit(ShowCartErrorState());
      }
    });
  }
//add to cart
  Future<void> addToCart(AddToCartEvent event, Emitter<CartState> emit) async {
    emit(AddToCartLoadingState());
    await CartRepo.addToCart(productId: event.productId).then((value) {
      if (value == true) {
        emit(AddToCartSuccessState());
      } else {
        emit(AddToCartErrorState());
      }
    });
  }
//remove from cart
  Future<void> removeFromCart(
      RemoveFromCartEvent event, Emitter<CartState> emit) async {
    emit(RemoveFromCartLoadingState());
    await CartRepo.removeFromCart(productId: event.productId)
        .then((value) {
      if (value == true) {
        emit(RemoveFromCartSuccessState());
      } else {
        emit(RemoveFromCartErrorState());
      }
    });
  }
  //update cart
  Future<void>updateCart(UpdateCartEvent event,Emitter<CartState>emit)async{
    emit(UpdateCartLoadingState());
    await CartRepo.updateCart(productId: event.productId,
        quantity: event.quantity).then((value){
          if(value ==true){
            emit(UpdateCartSuccessState());
          }else{
            emit(UpdateCartErrorState());
          }
    });
  }
}
