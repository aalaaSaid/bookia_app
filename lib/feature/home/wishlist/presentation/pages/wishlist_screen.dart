import 'package:booki_app/core/functions/dialog.dart';
import 'package:booki_app/core/widgets/custom_button.dart';
import 'package:booki_app/core/widgets/custom_small_button.dart';
import 'package:booki_app/feature/home/cart/presentation/bloc/cart_bloc.dart';
import 'package:booki_app/feature/home/cart/presentation/bloc/cart_event.dart';
import 'package:booki_app/feature/home/cart/presentation/bloc/cart_state.dart';
import 'package:booki_app/feature/home/wishlist/presentation/bloc/wishlist_bloc.dart';
import 'package:booki_app/feature/home/wishlist/presentation/bloc/wishlist_event.dart';
import 'package:booki_app/feature/home/wishlist/presentation/bloc/wishlist_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/text_style.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<WishlistBloc>().add(ShowWishlistEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wishlist',
          style: getTitleTextStyle(),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocConsumer<WishlistBloc, WishlistState>(
          listener: (context, state) {
            if (state is RemoveFromWishlistLoadingState ||
                state is ShowWishlistLoadingState ) {
              showLoadingDialog(context);
            } else if (state is RemoveFromWishlistErrorState) {
              Navigator.pop(context);
              showErrorDialog(context, 'Some thing went Wrong');
            } else if (state is RemoveFromWishlistSuccessState) {
              Navigator.pop(context);
              showErrorDialog(context, 'Book removed');
              context.read<WishlistBloc>().add(ShowWishlistEvent());
            } else if (state is ShowWishlistSuccessState) {
              Navigator.pop(context);
            }

            // TODO: implement listener
          },
          builder: (context, state) {
            var wishListBooks =
                context.read<WishlistBloc>().wishlistModel?.data?.data;
            return wishListBooks?.isEmpty ?? true
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.bookmark_border_outlined,
                          size: 100,
                          color: AppColors.primaryColor,
                        ),
                        const Gap(20),
                        Text(
                          'No Books found',
                          style: getHeadlineTextStyle(
                            color: AppColors.primaryColor,
                          ),
                        )
                      ],
                    ),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            separatorBuilder: (context, index) {
                              return const Divider(
                                color: AppColors.primaryColor,
                              );
                            },
                            itemCount: wishListBooks?.length ?? 0,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          wishListBooks?[index].image ?? '',
                                      width: 120,
                                      height: 150,
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                  const Gap(10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Text(
                                              wishListBooks?[index].name ?? '',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: getTitleTextStyle(),
                                            )),
                                            const Gap(20),
                                            CustomCloseButton(
                                              onpressed: () {
                                                context.read<WishlistBloc>().add(
                                                    RemoveFromWishlistEvent(
                                                        productId:
                                                            wishListBooks?[
                                                                        index]
                                                                    .id ??
                                                                0));
                                              },
                                            ),
                                          ],
                                        ),
                                        const Gap(5),
                                        Text(
                                          '${wishListBooks?[index].price ?? ''}EGP',
                                          style: getSubTitleTextStyle(),
                                        ),
                                        const Gap(10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            BlocListener<CartBloc, CartState>(
                                              listener: (context, state) {
                                                if(state is AddToCartLoadingState){
                                                  showLoadingDialog(context);
                                                }else if (state is AddToCartErrorState){
                                                  Navigator.pop(context);
                                                  showErrorDialog(context, 'Some thing went wrong');
                                                }else if(state is AddToCartSuccessState){
                                                  Navigator.pop(context);
                                                  showErrorDialog(context, 'Book added to card');
                                                }
                                                // TODO: implement listener
                                              },
                                              child: CustomButton(
                                                onPressed: () {
                                                  context.read<CartBloc>().add(
                                                      AddToCartEvent(
                                                          productId:
                                                              wishListBooks?[
                                                                          index]
                                                                      .id ??
                                                                  0));
                                                },
                                                text: 'ADD to Cart',
                                                width: 182,
                                                height: 40,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Gap(10),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}
