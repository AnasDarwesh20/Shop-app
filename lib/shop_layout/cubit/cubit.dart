
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_model/categories_model.dart';
import 'package:shop_app/models/shop_model/change_favorites.dart';
import 'package:shop_app/models/shop_model/favorites_model.dart';
import 'package:shop_app/models/shop_model/products_model.dart';
import 'package:shop_app/models/shop_model/shop_login_model.dart';
import 'package:shop_app/network/API/dio_helper.dart';
import 'package:shop_app/network/end_points.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shop_app/catigries/catigories_screen.dart';
import 'package:shop_app/shop_app/favoriets/favoriets_screen.dart';
import 'package:shop_app/shop_app/products/products_screen.dart';
import 'package:shop_app/shop_app/settings/sttings_screen.dart';
import 'package:shop_app/shop_layout/cubit/states.dart';

class ShopAppCubit extends Cubit<ShopAppStates>
{
  ShopAppCubit() : super (ShopAppInitialStates()) ;

  static ShopAppCubit get(context) => BlocProvider.of(context) ;

  int currentIndex = 0 ;

  List<Widget> bottomScreens = [
    ProductsScreen() ,
    CategoriesScreen() ,
    FavoritesScreen() ,
    SettingsScreen() ,
  ] ;

  void changeCurrentIndex(index) {
    currentIndex = index ;
    emit(ShopAppChangeCurrentIndexStates()) ;
  }

  Map<int , bool> favorites = {};

   HomeModel homeModel ;
  void getHomeData()
  {
    emit(ShopLoadingHomeDataState()) ;

    DioHelper.getData(url: HOME , token: token).then((value)
    {
      homeModel =HomeModel.fromJason(value.data) ;
      printFullText(homeModel.toString()) ;

      print(homeModel.status) ;

      homeModel.data.products.forEach((element)
      {
        favorites.addAll(
            {
              element.id : element.inFavorites ,
            }) ;
      }
      ) ;

      print(favorites.toString()) ;
      emit(ShopSuccessHomeDataState()) ;
    }).catchError((error)
    {
      print(error.toString()) ;
      emit(ShopErrorHomeDataState()) ;
    }) ;
  }

  CategoriesModel categoriesModel ;
  void getCategoriesData()
  {
    DioHelper.getData(url: GET_CATEGORIES , token: token).then((value)
    {
      categoriesModel =CategoriesModel.fromJson(value.data) ;
      emit(ShopSuccessCategoriesState()) ;
    }).catchError((error)
    {
      print(error.toString()) ;
      emit(ShopErrorCategoriesState()) ;
    }) ;
  }

  ChangeFavoritesModel changeFavoritesModel ;


  void changeFavorites( int productId )
  {
    favorites[productId] = !favorites[productId] ;
    emit(ShopFavoritesState()) ;
    DioHelper.postData(url: FAVORITES, data:
    {
      'product_id' : productId,
    } , token: token ,
    ).then((value)
    {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data) ;

      if(!changeFavoritesModel.status)
      {
        favorites[productId] = !favorites[productId] ;
        showToast(message: changeFavoritesModel.message, states: ToastStates.ERROR) ;
      } else
      {
        getFavoritesData() ;
      }
      emit(ShopSuccessFavoritesState()) ;
    }
    ).catchError((error)
    {
      favorites[productId] = !favorites[productId] ;
      emit(ShopErrorFavoritesState()
      ) ;
    }) ;
  }

  FavoritesModel favoritesModel ;
  void getFavoritesData()
  {
    emit(ShopLoadingGetFavoritesState()) ;
    DioHelper.getData(url: FAVORITES , token: token).then((value)
    {
      favoritesModel =FavoritesModel.fromJson(value.data) ;
      emit(ShopGetFavoritesSuccessState()) ;
    }).catchError((error)
    {
      print(error.toString()) ;
      emit(ShopGetFavoritesErrorState()) ;
    }) ;
  }

   ShopLoginModel userModel ;
  void getUserData()
  {
    DioHelper.getData(url: PROFILE , token: token).then((value)
    {
      userModel =ShopLoginModel.fromJason(value.data) ;
      emit(ShopGetUserSuccessState()) ;
    }).catchError((error)
    {
      print(error.toString()) ;
      emit(ShopGetUserErrorState()) ;
    }) ;
  }


  void updateUserData({
  @required String name ,
    @required String phone ,
    @required String email ,
})
  {
    emit(ShopUpdateLoadingState()) ;
    DioHelper.putData(
        url: UPDATE_PROFILE ,
        token: token ,
        data: {
          'name' : name ,
          'phone' : phone ,
          'email' : email  ,
        } ,
    ).then((value)
    {
      userModel =ShopLoginModel.fromJason(value.data) ;
      emit(ShopUpdateSucessState()) ;
    }).catchError((error)
    {
      print(error.toString()) ;
      emit(ShopUpdateErrorState()) ;
    }) ;
  }


}
