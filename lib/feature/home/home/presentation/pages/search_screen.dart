import 'package:booki_app/core/functions/dialog.dart';
import 'package:booki_app/core/utils/app_colors.dart';
import 'package:booki_app/core/utils/text_style.dart';
import 'package:booki_app/feature/home/home/presentation/bloc/home_bloc.dart';
import 'package:booki_app/feature/home/home/presentation/bloc/home_event.dart';
import 'package:booki_app/feature/home/home/presentation/bloc/home_state.dart';
import 'package:booki_app/feature/home/home/presentation/widgets/book_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final keyOfSearch = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        automaticallyImplyLeading: false,
        leading:IconButton(onPressed: (){
          Navigator.pop(context);
        },
            icon: const Icon(Icons.arrow_back_ios)),
        title: Text('Search for Books',
          style: getTitleTextStyle(
          ),),
      ),
      body: BlocListener<HomeBloc, HomeState>(
  listener: (context, state) {
    if(state is SearchLoadingState){
      showLoadingDialog(context);
    }else if (state is SliderErrorState){
      Navigator.pop(context);
      showErrorDialog(context, 'something went wrong');
    }
  },
  child: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: keyOfSearch,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintStyle: getSmallTextStyle(color: AppColors.greyColor),
                  hintText: 'Enter the name of book'
                ),
                onChanged: (value){
                  context.read<HomeBloc>().add(SearchEvent());
                },
              ),
              const Gap(20),
              Center(
                child: BlocBuilder<HomeBloc,HomeState>(
                    builder:(context,state){
                      if(state is SearchSuccessState){
                        Navigator.pop(context);
                        var booksModel = context.read<HomeBloc>().booksModel;
                        return BookItem(booksModel: booksModel);
                      }
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.bookmark,
                              size: 40,
                              color: AppColors.primaryColor,
                            ),
                            const Gap(10),
                            Text(
                              'No Books found',
                              style: getBodyTextStyle(
                                color: AppColors.primaryColor,
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
),
    );
  }
}
