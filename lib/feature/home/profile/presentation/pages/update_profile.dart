import 'dart:io';

import 'package:booki_app/core/functions/dialog.dart';
import 'package:booki_app/core/functions/navigation.dart';
import 'package:booki_app/feature/home/profile/presentation/bloc/profile_event.dart';
import 'package:booki_app/feature/home/profile/presentation/bloc/profile_state.dart';
import 'package:booki_app/feature/home/profile/presentation/pages/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/text_style.dart';
import '../../../../../core/widgets/custom_back_button.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../data/models/profile_model.dart';
import '../bloc/profile_bloc.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key,required this.profileModel});
  final ProfileModel? profileModel;

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  final formKey = GlobalKey<FormState>();

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = TextEditingController(text: widget.profileModel?.data?.name);
    phoneController = TextEditingController(text: widget.profileModel?.data?.phone);
    addressController = TextEditingController(text: widget.profileModel?.data?.address);

}
String path='';
/*uploadImageFromCamera ()async{
  var pickedImage = await ImagePicker().pickImage(
    source: ImageSource.camera,
  );
  if (pickedImage != null) {
    setState(() {
      path = pickedImage.path;
    });
  }

}

 */
uploadImageFromGallery()async{

  var pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery);
  if(pickedImage!=null){
    setState(() {
      path=pickedImage.path;
    });
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: const CustomBackButton(),
      ),
      body: BlocListener<ProfileBloc, ProfileState>(
  listener: (context, state) {
    // TODO: implement listener
    if(state is UpdateProfileLoadingState){
      showLoadingDialog(context);
    }else if(state is UpdateProfileErrorState){
      Navigator.pop(context);
      showErrorDialog(context, 'Something went wrong');
    }else if (state is UpdateProfileSuccessState){
      //Navigator.pop(context);
      //showErrorDialog(context, 'Your Profile updated Successful');
    context.read<ProfileBloc>().add(ShowProfileEvent());
    Navigator.pop(context);
    Navigator.pop(context);
    //navigateRemove(context, const ProfileScreen());
    }
  },
  child: Padding(
        padding: const EdgeInsets.all(22),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: path.isNotEmpty?FileImage(File(path))as ImageProvider:
                      NetworkImage(widget.profileModel?.data?.image??'https://static.vecteezy.com/system/resources/previews/008/442/086/original/illustration-of-human-icon-user-symbol-icon-modern-design-on-blank-background-free-vector.jpg'),
                      backgroundColor: AppColors.accentColor,
                      radius: 100,
                    ),
                    Positioned(
                        bottom: 4,
                        right: 4,
                        child: CircleAvatar(
                          radius: 20,
                          child: IconButton(
                              style: IconButton.styleFrom(
                                  backgroundColor: AppColors.accentColor),
                              onPressed: () {
                                uploadImageFromGallery();
                              },
                              icon: const Icon(
                                Icons.camera_alt,
                                color: AppColors.darkColor,
                              )),
                        ))
                  ],
                ),
                const Gap(10),
                Text(
                  'Update profile',
                  style: getHeadlineTextStyle(),
                ),
                const Gap(30),
                TextFormField(
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'Username',
                    hintStyle: TextStyle(color: AppColors.greyColor),
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
                TextFormField(
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'Phone',
                    hintStyle: TextStyle(color: AppColors.greyColor),
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
                TextFormField(
                  keyboardType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    hintText: 'Address',
                    hintStyle: TextStyle(color: AppColors.greyColor),
                  ),
                  controller: addressController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the correct input';
                    }
                    return null;
                  },
                ),

              ],
            ),
          ),
        ),
      ),

),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CustomButton(
          onPressed: () {
            if(formKey.currentState!.validate()){
              if(path.isNotEmpty){
                context.read<ProfileBloc>().add(UpdateProfileEvent(
                    name: nameController.text,
                    phone: phoneController.text,
                    address: addressController.text,
                    image: path));
              }else{
                context.read<ProfileBloc>().add(UpdateProfileEvent(
                  name:nameController.text ,
                  phone: phoneController.text,
                  address: addressController.text,
                ));
              }

            }
          },
          text: 'Update profile',
          width: double.infinity,
        ),
      ) ,
    );
  }
}
