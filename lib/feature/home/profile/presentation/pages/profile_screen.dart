import 'package:booki_app/core/functions/dialog.dart';
import 'package:booki_app/core/functions/navigation.dart';
import 'package:booki_app/core/utils/app_colors.dart';
import 'package:booki_app/core/utils/text_style.dart';
import 'package:booki_app/feature/home/profile/presentation/bloc/profile_bloc.dart';
import 'package:booki_app/feature/home/profile/presentation/bloc/profile_event.dart';
import 'package:booki_app/feature/home/profile/presentation/bloc/profile_state.dart';
import 'package:booki_app/feature/home/profile/presentation/pages/update_password.dart';
import 'package:booki_app/feature/home/profile/presentation/pages/update_profile.dart';
import 'package:booki_app/feature/home/profile/presentation/widgets/custom_listtile.dart';
import 'package:booki_app/feature/intro_pages/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ProfileBloc>().add(ShowProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(

      listener: (context, state) {
       if(state is LogoutLoadingState){
         showLoadingDialog(context);
       }else if(state is LogoutErrorState){
         Navigator.pop(context);
         showErrorDialog(context, 'Something went wrong');
       }else if (state is LogoutSuccessState){
         Navigator.pop(context);
         navigateRemove(context, const WelcomeScreen());
       }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile',
            style: getTitleTextStyle(),
          ),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {
              context.read<ProfileBloc>().add(LogoutEvent());

            },
                icon: SvgPicture.asset('assets/icons/Logout.svg'))
          ],
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            var profileModel = context
                .read<ProfileBloc>()
                .profileModel;
            return Skeletonizer(
              enabled: state is! ShowProfileSuccessState,
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  children: [
                    const Spacer(),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                              profileModel?.data?.image ??
                                  'https://tse2.mm.bing.net/th?id=OIP.lvzPu-WOW4Iv7QyjP-IkrgHaHa&pid=Api&P=0&h=220'),
                          backgroundColor: AppColors.accentColor,

                        ),
                        const Gap(10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(profileModel?.data?.name ?? '',
                                style: getSubTitleTextStyle(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              const Gap(10),
                              Text(profileModel?.data?.email ?? 'oops',
                                style: getSubTitleTextStyle(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    CustomListtile(text: 'My Orders', onPressed: () {}),
                    const Gap(10),
                    CustomListtile(text: 'Edit Profile', onPressed: () {
                      navigateTO(context, UpdateProfile(
                        profileModel: profileModel!,
                      ));
                    }),
                    const Gap(10),
                    CustomListtile(text: 'Reset Password', onPressed: () {
                      navigateTO(context, UpdatePassword());
                    }),
                    const Gap(10),
                    CustomListtile(text: 'FAQ', onPressed: () {}),
                    const Gap(10),
                    CustomListtile(text: 'Contact Us', onPressed: () {}),
                    const Gap(10),
                    CustomListtile(text: 'Privacy & Terms', onPressed: () {}),
                    const Spacer(),

                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
