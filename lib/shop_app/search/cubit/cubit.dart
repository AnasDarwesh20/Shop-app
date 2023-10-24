import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_model/search_model.dart';
import 'package:shop_app/network/API/dio_helper.dart';
import 'package:shop_app/network/end_points.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shop_app/search/cubit/states.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel searchModel;

  void search({
    @required String text,
  }) {
    emit(SearchLoadingState());
    DioHelper.postData(
      url: SEARCH,
      data: {
        'text': text,
      },
      token: token,
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchLoadingSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchLoadingErrorState());
    });
  }
}
