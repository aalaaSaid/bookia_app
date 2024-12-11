import 'package:booki_app/feature/home/wishlist/data/models/wishlist_model.dart';
import 'package:booki_app/feature/home/wishlist/data/repo/wishlist_repo.dart';
import 'package:booki_app/feature/home/wishlist/presentation/bloc/wishlist_event.dart';
import 'package:booki_app/feature/home/wishlist/presentation/bloc/wishlist_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistBloc extends Bloc<WishlistEvent,WishlistState>{
  WishlistBloc():super (InitialWishlist()){
    on<ShowWishlistEvent>(showWishlist);
    on<AddToWishlistEvent>(addToWishlist);
    on<RemoveFromWishlistEvent>(removeFromWishlist);
  }
  WishlistModel? wishlistModel;
  Future<void>showWishlist (ShowWishlistEvent event,Emitter<WishlistState>emit)async{
    emit(ShowWishlistLoadingState());
    await WishListRepo.getWishlist().then((value){
      if(value !=null){
        wishlistModel = value;
        emit(ShowWishlistSuccessState());
      }else{
        emit(ShowWishlistErrorState());
      }
    });
  }

  Future<void>addToWishlist (AddToWishlistEvent event , Emitter<WishlistState>emit)async{
    emit(AddWishlistLoadingState());
    await WishListRepo.addToWishList(productId: event.productId).then((value){
      if(value ==true){
        emit(AddWishlistSuccessState());
      }else{
        emit(AddWishlistErrorState());
      }
    });

  }

  Future<void>removeFromWishlist (RemoveFromWishlistEvent event , Emitter<WishlistState>emit)async{
    emit(RemoveFromWishlistLoadingState());
    await WishListRepo.removeFromWishList(productId: event.productId).then((value){
      if(value ==true){
        emit(RemoveFromWishlistSuccessState());
      }else{
        emit(RemoveFromWishlistErrorState());
      }
    });

  }

}