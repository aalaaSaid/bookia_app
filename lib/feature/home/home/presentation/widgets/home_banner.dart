import 'package:booki_app/feature/home/home/presentation/bloc/home_bloc.dart';
import 'package:booki_app/feature/home/home/presentation/bloc/home_event.dart';
import 'package:booki_app/feature/home/home/presentation/bloc/home_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../core/utils/app_colors.dart';

class HomeBanner extends StatefulWidget {
  const HomeBanner({super.key});

  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeBloc>().add(HomeSliderEvent());
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        var slider = context.read<HomeBloc>().sliderModel?.data?.sliders;
        //print('${slider?[0].image} the image');
        if(state is !SliderErrorState){
        return Column(
          children: [
            CarouselSlider.builder(
              itemCount: slider?.length??0,
              itemBuilder: (context, index, realIndex) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                      imageUrl:slider?[index].image??'',
                    //width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.greyColor,
                        //value: 0.5,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                    const Icon(
                      Icons.error,
                      size: double.infinity,
                      color: AppColors.primaryColor,
                    ),

                  ),
                );
              },
              options: CarouselOptions(
                height: 150,
                viewportFraction: 0.8,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                autoPlay: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
            const Gap(10),
            SmoothPageIndicator(
              controller: PageController(initialPage: currentIndex),
              count: 3,
              effect: const ScrollingDotsEffect(
                dotColor: AppColors.borderColor,
                activeDotColor: AppColors.primaryColor,
              ),
            )
          ],
        ); }else{
          return const Text('ERROR');
        }
      },
    );
  }
}
