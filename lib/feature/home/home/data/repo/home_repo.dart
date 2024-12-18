import 'dart:developer';

import 'package:booki_app/core/services/remote/end_point.dart';
import 'package:booki_app/feature/home/home/data/models/home_books_model.dart';
import 'package:dio/dio.dart';
import '../models/slider_model.dart';

class HomeRepo {
  //get books
static Future <BooksModel?>getArrivalBooks()async{
  try{
    var response = await Dio().get(AppEndPoint.baseUrl+AppEndPoint.getBooks);
    if(response.statusCode==200){
      //print(response.data);
      return BooksModel.fromJson(response.data);
    }else{
      return null ;
    }

  }on Exception catch(e){
    log(e.toString());
    return null ;
  }
}
//slider books
static Future<SliderModel?> getSlider()async {
  try {
    var response = await Dio().get(AppEndPoint.baseUrl + AppEndPoint.slider);
    if (response.statusCode == 200) {
     // print(response.data);
      return SliderModel.fromJson(response.data);
    } else {
      //print('error ya aalaa ');
      return null;
    }
  }on Exception catch(e){
    log(e.toString());
    return null ;
  }

  }
  //search for books
static Future<BooksModel?>searchBook()async{
  try{
    var response = await Dio().get(AppEndPoint.baseUrl+AppEndPoint.search);
    if(response.statusCode==200){
      return BooksModel.fromJson(response.data);
    }else {
      return null ;
    }
  }on Exception catch(e){
    log(e.toString());
    return null ;
  }
}
}