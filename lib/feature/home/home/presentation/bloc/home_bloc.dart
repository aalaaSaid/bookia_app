import 'package:booki_app/feature/home/home/data/models/home_books_model.dart';
import 'package:booki_app/feature/home/home/data/models/slider_model.dart';
import 'package:booki_app/feature/home/home/data/repo/home_repo.dart';
import 'package:booki_app/feature/home/home/presentation/bloc/home_event.dart';
import 'package:booki_app/feature/home/home/presentation/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent,HomeState>{
  HomeBloc():super(HomeInitialState()) {
    on<HomeGetNewArrivalsEvent>(getNewArrivalBooks);
    on<HomeSliderEvent>(getSliderData);
  }
  BooksModel? booksModel ;
 Future<void> getNewArrivalBooks (HomeGetNewArrivalsEvent event,Emitter<HomeState>emit)async{
    emit(HomeLoadingState());
    await HomeRepo.getArrivalBooks().then((value){
      if(value != null){
        booksModel = value;
        emit(HomeSuccessState());
      }else{
        emit(HomeErrorState());
      }
    });

  }
  SliderModel? sliderModel;
  Future<void>getSliderData (HomeSliderEvent event,Emitter<HomeState>emit)async{
   emit (SliderLoadingState());
   await HomeRepo.getSlider().then((value){
     if(value != null){
       sliderModel = value ;
       emit(SliderSuccessState());
     }else{
       emit(SliderErrorState());
     }
   });


  }

}