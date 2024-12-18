import 'package:booki_app/core/functions/navigation.dart';
import 'package:booki_app/core/utils/text_style.dart';
import 'package:booki_app/feature/home/home/presentation/pages/search_screen.dart';
import 'package:booki_app/feature/home/home/presentation/widgets/book_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../widgets/home_banner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              SvgPicture.asset(
                'assets/images/logo.svg',
                height: 30,
                width: 99,
              ),
            ],
          ),
          actions: [
            Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset('assets/icons/notification.svg')),
                IconButton(
                    onPressed: () {
                      navigateTO(context, const SearchScreen());
                    },
                    icon: SvgPicture.asset('assets/icons/search.svg'))
              ],
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HomeBanner(),
                const Gap(20),
                Text(
                  'Popular Books',
                  style: getTitleTextStyle(),
                ),
                const Gap(10),
               const BookBok(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
