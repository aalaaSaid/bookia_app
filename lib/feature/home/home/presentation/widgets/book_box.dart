//import 'package:booki_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:booki_app/core/functions/navigation.dart';
import 'package:booki_app/feature/home/home/presentation/bloc/home_bloc.dart';
import 'package:booki_app/feature/home/home/presentation/bloc/home_event.dart';
import 'package:booki_app/feature/home/home/presentation/bloc/home_state.dart';
import 'package:booki_app/feature/home/home/presentation/pages/book_description.dart';
import 'package:cached_network_image/cached_network_image.dart';
//import 'package:cached_network_image/cached_network_image.dart';
//import 'package:booki_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/text_style.dart';
import '../../../../../core/widgets/custom_button.dart';

class BookBok extends StatefulWidget {
  const BookBok({super.key});

  @override
  State<BookBok> createState() => _BookBokState();
}

class _BookBokState extends State<BookBok> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeBloc>().add(HomeGetNewArrivalsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        var books = context.read<HomeBloc>().booksModel?.data?.products;
        return Skeletonizer(
          enabled: state is! HomeSuccessState,
          child: GridView.builder(
              itemCount: books?.length ?? 0,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  mainAxisExtent: 280),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    navigateTO(
                        context, BookDescription(product: books![index]));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Hero(
                                tag: books?[index].id ?? '',
                                child: CachedNetworkImage(
                                  imageUrl: books?[index].image ?? '',
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.primaryColor,
                                      //value: .5,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.error,
                                    size: double.infinity,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              )),
                        ),
                        const Gap(10),
                        Text(
                          books?[index].name ?? '',
                          style: getSmallTextStyle(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Gap(10),
                        Row(
                          children: [
                            Text(
                              '${books?[index].price ?? ''} \$',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: getSmallTextStyle(),
                            ),
                            const Gap(5),
                            Expanded(
                              child: CustomButton(
                                onPressed: () {},
                                text: 'Buy',
                                height: 35,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
        );
      },
    );
  }
}
