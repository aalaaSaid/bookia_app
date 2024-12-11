import 'package:booki_app/core/functions/dialog.dart';
import 'package:booki_app/core/utils/text_style.dart';
import 'package:booki_app/core/widgets/custom_back_button.dart';
import 'package:booki_app/core/widgets/custom_button.dart';
import 'package:booki_app/feature/home/cart/presentation/bloc/cart_bloc.dart';
import 'package:booki_app/feature/home/cart/presentation/bloc/cart_event.dart';
import 'package:booki_app/feature/home/cart/presentation/bloc/cart_state.dart';
import 'package:booki_app/feature/home/home/data/models/home_books_model.dart';
import 'package:booki_app/feature/home/wishlist/presentation/bloc/wishlist_bloc.dart';
import 'package:booki_app/feature/home/wishlist/presentation/bloc/wishlist_event.dart';
import 'package:booki_app/feature/home/wishlist/presentation/bloc/wishlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class BookDescription extends StatelessWidget {
  const BookDescription({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Row(
          children: [
            CustomBackButton(),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                context
                    .read<WishlistBloc>()
                    .add(AddToWishlistEvent(productId: product.id ?? 0));
              },
              icon: SvgPicture.asset('assets/icons/Bookmark.svg')),
        ],
      ),
      body: BlocListener<WishlistBloc, WishlistState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is AddWishlistLoadingState) {
            showLoadingDialog(context);
          } else if (state is AddWishlistErrorState) {
            Navigator.pop(context);
            showErrorDialog(context, 'Some thing went wrong');
          } else if (state is AddWishlistSuccessState) {
            Navigator.pop(context);
            showErrorDialog(context, 'Book added to Wishlist');
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: Hero(
                            tag: product.id ?? '',
                            child: Image.network(
                              product.image ?? '',
                              height: 271,
                              width: 183,
                            ),
                          ),
                        ),
                        const Gap(20),
                        Text(
                          product.name ?? '',
                          style: getTitleTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                        const Gap(10),
                        Text(
                          product.category ?? '',
                          style: getSubTitleTextStyle(),
                        ),
                        const Gap(10),
                        Text(
                          product.description ?? '',
                          style: getSmallTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text('${product.price ?? ''} \$',style: getTitleTextStyle(),),
                    const Spacer(),
                    BlocListener<CartBloc, CartState>(
                      listener: (context, state) {
                        // TODO: implement listener
                        if(state is AddToCartLoadingState){
                          showLoadingDialog(context);
                        }else if (state is AddToCartErrorState){
                          Navigator.pop(context);
                          showErrorDialog(context, 'Some thing went wrong');
                        }else if(state is AddToCartSuccessState){
                          Navigator.pop(context);
                          showErrorDialog(context, 'Book added to card');
                        }
                      },
                      child: CustomButton(
                        onPressed: () {
                          context.read<CartBloc>().add(AddToCartEvent(productId:product.id??0 ));
                        },
                        text: 'Add to Cart',
                        width: 212,
                        height: 50,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
