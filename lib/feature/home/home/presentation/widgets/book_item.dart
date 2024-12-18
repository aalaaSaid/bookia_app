import 'package:booki_app/feature/home/home/data/models/home_books_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../core/functions/navigation.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/text_style.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../pages/book_description.dart';
class BookItem extends StatelessWidget {
  const BookItem({super.key,required this.booksModel});
  final BooksModel? booksModel;

  @override
  Widget build(BuildContext context) {
    var books = booksModel?.data?.products;
    return GridView.builder(
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
        });
  }
}
