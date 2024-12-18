//import 'package:booki_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:booki_app/core/functions/navigation.dart';
import 'package:booki_app/feature/home/home/presentation/bloc/home_bloc.dart';
import 'package:booki_app/feature/home/home/presentation/bloc/home_event.dart';
import 'package:booki_app/feature/home/home/presentation/bloc/home_state.dart';
import 'package:booki_app/feature/home/home/presentation/pages/book_description.dart';
import 'package:booki_app/feature/home/home/presentation/widgets/book_item.dart';
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
        var booksModel = context.read<HomeBloc>().booksModel;
        var books = booksModel?.data?.products;
        return Skeletonizer(
          enabled: state is! HomeSuccessState,
          child: BookItem(booksModel: booksModel),
        );
      },
    );
  }
}
