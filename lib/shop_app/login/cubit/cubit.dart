

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_model/shop_login_model.dart';
import 'package:shop_app/network/API/dio_helper.dart';
import 'package:shop_app/network/end_points.dart';
import 'package:shop_app/shop_app/login/cubit/states.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>
{
  ShopLoginCubit() : super(ShopLoginInitialState()) ;

  static ShopLoginCubit get(context) => BlocProvider.of(context) ;

   ShopLoginModel shopLoginModel ;
   ShopLoginModelError shopLoginModelError ;

  void userLogin ( {
  @required String email ,
  @required String password  ,
})
  {
    emit(ShopLoginLodingState()) ;

    DioHelper.postData(
            url: LOGIN ,
            data:{
              'email' : email ,
              'password' : password ,
            } ,
        ).then((value)
    {
      print(value.data) ;
      shopLoginModel = ShopLoginModel.fromJason(value.data) ;
      emit(ShopLoginSucessState(shopLoginModel)) ;
    }).catchError((error)
    {
      print(error.toString()) ;
      emit(ShopLoginErrorState(error.toString())) ;
    }) ;


  }
}