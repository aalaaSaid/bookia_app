import 'package:booki_app/core/functions/dialog.dart';
import 'package:booki_app/core/functions/navigation.dart';
import 'package:booki_app/core/utils/text_style.dart';
import 'package:booki_app/core/widgets/custom_back_button.dart';
import 'package:booki_app/feature/home/cart/data/governorate_list.dart';
import 'package:booki_app/feature/home/cart/data/models/cart_model.dart';
//import 'package:booki_app/feature/home/cart/data/models/cart_model.dart';
import 'package:booki_app/feature/home/cart/presentation/bloc/cart_bloc.dart';
import 'package:booki_app/feature/home/cart/presentation/bloc/cart_event.dart';
import 'package:booki_app/feature/home/cart/presentation/bloc/cart_state.dart';
import 'package:booki_app/feature/home/cart/presentation/pages/success_checkout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/custom_button.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key,required this.total,required this.cartModel});
  final String? total;
  final CartModel? cartModel;
  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var addressController = TextEditingController();
  var phoneController = TextEditingController();
  int governorateId=1;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
  listener: (context, state) {
    if(state is CheckoutLoadingState){
      showLoadingDialog(context);
    }else if(state is CheckoutErrorState){
      Navigator.pop(context);
      showErrorDialog(context, 'Something Wrong');
    }else if(state is CheckoutSuccessState){
      Navigator.pop(context);
      navigateTO(context, const SuccessCheckout());
    }
  },
  child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const CustomBackButton(),
        title: Text(
          'Checkout',
          style: getTitleTextStyle(),
        ),
      ),
      body:Padding(
            padding: const EdgeInsets.all(22),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  //name
                  TextFormField(
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Full Name',
                      hintStyle: getSmallTextStyle(
                        color: AppColors.greyColor,
                      ),
                    ),
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the correct input';
                      }
                      return null;
                    },
                  ),
                  const Gap(10),
                  //email
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: getSmallTextStyle(
                        color: AppColors.greyColor,
                      ),
                    ),
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the correct input';
                      }
                      return null;
                    },
                  ),
                  const Gap(10),
                  //address
                  TextFormField(
                    keyboardType: TextInputType.streetAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Address',
                      hintStyle: getSmallTextStyle(
                        color: AppColors.greyColor,
                      ),
                    ),
                    controller: addressController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the correct input';
                      }
                      return null;
                    },
                  ),
                  const Gap(10),
                  //phone
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Phone',
                      hintStyle: getSmallTextStyle(
                        color: AppColors.greyColor,
                      ),
                    ),
                    controller: phoneController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the correct input';
                      }
                      return null;
                    },
                  ),
                  const Gap(10),
                  //list
                  Container(
                    width: double.infinity,
                    height: 60,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: AppColors.accentColor,
                        borderRadius: BorderRadius.circular(7)
                    ),
                    child: DropdownButton(
                        dropdownColor: AppColors.secondaryColor,
                        value: governorateId,
                        isExpanded: true,
                        items: getGovernorate().map((city) =>
                            DropdownMenuItem(
                              value: city.id,
                              child: Text(city.governorateNameEn!),),).toList(),
                        onChanged: (value) {
                          setState(() {
                            governorateId = value as int;
                          });
                        }),
                  ),
                  const Spacer(),
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
                            '${widget.total}',
                            style: getSubTitleTextStyle(),
                          ),
                        ],
                      ),
                      const Gap(5),
                      CustomButton(
                        onPressed: () {
                          if(formKey.currentState!.validate()){
                            context.read<CartBloc>().add(CheckoutEvent());
                          }
                        },
                        text: 'Checkout',
                        width: double.infinity,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )

    ),
);
  }
}
