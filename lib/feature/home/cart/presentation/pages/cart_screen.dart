import 'package:booki_app/core/functions/dialog.dart';
import 'package:booki_app/core/functions/navigation.dart';
import 'package:booki_app/core/widgets/custom_button.dart';
import 'package:booki_app/feature/home/cart/presentation/bloc/cart_bloc.dart';
import 'package:booki_app/feature/home/cart/presentation/bloc/cart_event.dart';
import 'package:booki_app/feature/home/cart/presentation/bloc/cart_state.dart';
import 'package:booki_app/feature/home/cart/presentation/pages/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/text_style.dart';
import '../../../../../core/widgets/custom_small_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<CartBloc>().add(ShowCartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: getTitleTextStyle(),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<CartBloc, CartState>(listener: (context, state) {
        // TODO: implement listener
        if (state is RemoveFromCartLoadingState ||
            state is ShowCartLoadingState||state is UpdateCartLoadingState) {
          showLoadingDialog(context);
        } else if (state is RemoveFromCartErrorState||state is UpdateCartErrorState) {
          Navigator.pop(context);
          showErrorDialog(context, 'Something went Wrong');
        } else if (state is RemoveFromCartSuccessState) {
          Navigator.pop(context);
          showErrorDialog(context, 'The book removed');
          context.read<CartBloc>().add(ShowCartEvent());
        } else if (state is ShowCartSuccessState) {
          Navigator.pop(context);
        }else if (state is UpdateCartSuccessState){
          Navigator.pop(context);
          context.read<CartBloc>().add(ShowCartEvent());
        }
      }, builder: (context, state) {
        var cartModel = context.read<CartBloc>().cartModel;
        return cartModel?.data?.cartItems?.isEmpty ?? true
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
            : Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return const Divider(
                              color: AppColors.primaryColor,
                            );
                          },
                          itemCount: cartModel?.data?.cartItems?.length ?? 0,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    cartModel?.data?.cartItems?[index]
                                            .itemProductImage ??
                                        '',
                                    fit: BoxFit.cover,
                                    width: 120,
                                    height: 150,
                                  ),
                                ),
                                const Gap(20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                            cartModel?.data?.cartItems?[index]
                                                    .itemProductName ??
                                                '',
                                            style: getSubTitleTextStyle(),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          )),
                                          const Gap(10),
                                          CustomCloseButton(onpressed: () {
                                            context.read<CartBloc>().add(
                                                RemoveFromCartEvent(
                                                    productId: cartModel
                                                            ?.data?.cartItems?[index]
                                                            .itemId ??
                                                        0));
                                          }),
                                        ],
                                      ),
                                      const Gap(7),
                                      Text(
                                        '${cartModel?.data?.cartItems?[index].itemProductPrice}  EGP',
                                        style: getSubTitleTextStyle(),
                                      ),
                                      const Gap(10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          FloatingActionButton.small(
                                            onPressed: () {
                                              if ((cartModel?.data?.cartItems?[index]
                                                          .itemQuantity ??
                                                      0) <
                                                  (cartModel?.data?.cartItems?[index]
                                                          .itemProductStock ??
                                                      0)) {
                                                context.read<CartBloc>().add(
                                                    UpdateCartEvent(
                                                        productId: cartModel
                                                                ?.data?.cartItems?[
                                                                    index]
                                                                .itemId ??
                                                            0,
                                                        quantity: (cartModel
                                                                    ?.data?.cartItems?[
                                                                        index]
                                                                    .itemQuantity ??
                                                                0) +
                                                            1));
                                              }
                                            },
                                            elevation: 0,
                                            backgroundColor:
                                                AppColors.accentColor,
                                            child: const Icon(Icons.add),
                                          ),
                                          const Gap(5),
                                          Text(
                                            '${cartModel?.data?.cartItems?[index].itemQuantity}',
                                            style: getSubTitleTextStyle(),
                                          ),
                                          const Gap(5),
                                          FloatingActionButton.small(
                                            onPressed: () {
                                              if ((cartModel?.data?.cartItems?[index]
                                                          .itemQuantity ??
                                                      0) >
                                                  1) {
                                                context.read<CartBloc>().add(
                                                    UpdateCartEvent(
                                                        productId: cartModel
                                                                ?.data?.cartItems?[
                                                                    index]
                                                                .itemId ??
                                                            0,
                                                        quantity: (cartModel
                                                                    ?.data?.cartItems?[
                                                                        index]
                                                                    .itemQuantity ??
                                                                0) -
                                                            1));
                                              }
                                            },
                                            elevation: 0,
                                            backgroundColor:
                                                AppColors.accentColor,
                                            child: const Icon(Icons.remove),
                                          ),
                                        ],
                                      ),
                                      const Gap(20),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                    Column(
                      children: [
                        const Gap(10),
                        Row(
                          children: [
                            Text(
                              'Total :',
                              style: getTitleTextStyle(),
                            ),
                            const Spacer(),
                            Text(
                              '${cartModel?.data?.total} EGP',
                              style: getSubTitleTextStyle(),
                            ),
                          ],
                        ),
                        const Gap(5),
                        CustomButton(
                          onPressed: () {
                            navigateTO(context, CheckoutScreen(total: cartModel?.data?.total??'',
                            cartModel: cartModel,
                            ));
                          },
                          text: 'Checkout',
                          width: double.infinity,
                        ),
                      ],
                    ),
                  ],
                ),
              );
      }),
    );
  }
}
