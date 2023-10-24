

import 'package:bloc/bloc.dart';
import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/shop_model/shop_login_model.dart';
import 'package:shop_app/network/API/dio_helper.dart';
import 'package:shop_app/network/end_points.dart';
import 'package:shop_app/shop_app/register/cubit/state.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>
{
  ShopRegisterCubit() : super(ShopRegisterInitialState()) ;

  static ShopRegisterCubit get(context) => BlocProvider.of(context) ;

  ShopLoginModel shopLoginModel ;
  ShopLoginModelError shopLoginModelError ;

  void userRegister( {
    @required String email ,
    @required String password  ,
    @required String name  ,
    @required String phone  ,
  })
  {
    emit(ShopRegisterLodingState()) ;

    DioHelper.postData(
      url: REGISTER ,
      data:
      {
        'name' : name ,
        'phone' : phone ,
        'email' : email ,
        'password' : password ,
      } ,
    ).then((value)
    {
      print(value.data) ;
      shopLoginModel = ShopLoginModel.fromJason(value.data) ;
      emit(ShopRegisterSucessState(shopLoginModel)) ;
    }).catchError((error)
    {
      print(error.toString()) ;
      emit(ShopRegisterErrorState(error.toString())) ;
    }) ;


  }
}