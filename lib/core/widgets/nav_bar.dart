import 'package:booki_app/core/utils/app_colors.dart';
import 'package:booki_app/core/utils/text_style.dart';
import 'package:booki_app/feature/home/cart/presentation/pages/cart_screen.dart';
import 'package:booki_app/feature/home/profile/presentation/pages/profile_screen.dart';
import 'package:booki_app/feature/home/wishlist/presentation/pages/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../feature/home/home/presentation/pages/home_screen.dart';


class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int currentIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const WishlistScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        backgroundColor: AppColors.whiteColor,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedItemColor: AppColors.primaryColor,
        items: [
          BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(
                  color: AppColors.primaryColor, 'assets/icons/Home.svg'),
              icon: SvgPicture.asset('assets/icons/Home.svg'),
              label: 'Home'

          ),
          BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(
                'assets/icons/Bookmark.svg',
                color: AppColors.primaryColor,
              ),
              icon: SvgPicture.asset('assets/icons/Bookmark.svg'),
              label: 'Wishlist'),
          BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(
                'assets/icons/Category.svg',
                color: AppColors.primaryColor,
              ),
              icon: SvgPicture.asset('assets/icons/Category.svg'),
              label: 'Cart'),
          BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(
                'assets/icons/Profile.svg',
                color: AppColors.primaryColor,
              ),
              icon: SvgPicture.asset('assets/icons/Profile.svg'),
              label: 'Profile'),
        ],
        onTap: (value) {
          currentIndex = value;
          setState(() {});
        },
      ),
    ));
  }
}
