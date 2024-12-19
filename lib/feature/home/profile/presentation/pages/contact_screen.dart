import 'package:booki_app/core/functions/dialog.dart';
import 'package:booki_app/core/utils/app_colors.dart';
import 'package:booki_app/core/utils/text_style.dart';
import 'package:booki_app/core/widgets/custom_button.dart';
import 'package:booki_app/feature/home/profile/data/models/profile_model.dart';
import 'package:booki_app/feature/home/profile/presentation/bloc/profile_bloc.dart';
import 'package:booki_app/feature/home/profile/presentation/bloc/profile_event.dart';
import 'package:booki_app/feature/home/profile/presentation/bloc/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key,required this.profileModel});
  final ProfileModel profileModel;

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  var emailController = TextEditingController();
  final subController = TextEditingController();
  final masController = TextEditingController();
  var  nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController(text: widget.profileModel.data?.email);
    nameController = TextEditingController(text: widget.profileModel.data?.name);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contact us Now',
          style: getTitleTextStyle(),
        ),
      ),
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ContactLoadingState) {
            showLoadingDialog(context);
          } else if (state is ContactErrorState) {
            Navigator.pop(context);
            showErrorDialog(context, 'Something went wrong');
          } else if (state is ContactSuccessState) {
            Navigator.pop(context);
            showErrorDialog(context, 'Your Message send Successful');
            Navigator.pop(context);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Your Name',
                      style: getTitleTextStyle(),
                    ),
                  ),
                  const Gap(10),
                  TextFormField(
                    controller: nameController,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null) {
                        return 'Please enter it';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        hintText: 'Name',
                        hintStyle:
                            getSmallTextStyle(color: AppColors.greyColor)),
                  ),
                  const Gap(20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Your Email',
                      style: getTitleTextStyle(),
                    ),
                  ),
                  const Gap(10),
                  TextFormField(
                    controller: emailController,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null) {
                        return 'Please enter it';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: 'Your Email',
                        hintStyle:
                            getSmallTextStyle(color: AppColors.greyColor)),
                  ),
                  const Gap(20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Subject',
                      style: getTitleTextStyle(),
                    ),
                  ),
                  const Gap(10),
                  TextFormField(
                    controller: subController,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null) {
                        return 'Please enter it';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: 'subject',
                        hintStyle:
                            getSmallTextStyle(color: AppColors.greyColor)),
                  ),
                  const Gap(20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Massage',
                      style: getTitleTextStyle(),
                    ),
                  ),
                  const Gap(10),
                  TextFormField(
                    maxLines: 4,
                    controller: masController,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value == null) {
                        return 'Please enter it';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: 'Massage',
                        hintStyle:
                            getSmallTextStyle(color: AppColors.greyColor)),
                  ),
                  const Gap(30),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                context.read<ProfileBloc>().add(ContactEvent(
                    name: nameController.text,
                    email: emailController.text,
                    massage: masController.text,
                    subject: subController.text));
              }
            },
            text: 'Send'),
      ),
    );
  }
}
