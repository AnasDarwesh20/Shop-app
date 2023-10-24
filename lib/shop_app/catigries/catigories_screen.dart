import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_model/categories_model.dart';
import 'package:shop_app/shop_layout/cubit/cubit.dart';
import 'package:shop_app/shop_layout/cubit/states.dart';

import '../../shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit , ShopAppStates>(
      listener: (context, state) {},
      builder: (context , state)
      {
        return ListView.separated(
          itemBuilder: (context , index)=> buildCatItem(ShopAppCubit.get(context).categoriesModel.data.data[index]),
          separatorBuilder:(context , index)=>myDivider(),
          itemCount:  ShopAppCubit.get(context).categoriesModel.data.data.length ,
        );
      },
    );
  }

  Widget buildCatItem (DataModel model) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          image : NetworkImage('${model.image}'),
          fit: BoxFit.cover,
          height: 100.0,
          width: 100.0,
        ) ,
        SizedBox(
          width: 10.0,
        ) ,
        Text(model.name ,
          style: TextStyle(
              fontSize: 20.0
          ) ,
        ) ,
        Spacer() ,
        Icon(
          Icons.arrow_forward_ios_outlined  ,
        ) ,
      ],
    ),
  );
}
