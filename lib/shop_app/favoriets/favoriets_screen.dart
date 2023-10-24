import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shop_layout/cubit/cubit.dart';
import 'package:shop_app/shop_layout/cubit/states.dart';

class FavoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopAppCubit , ShopAppStates>(
      listener: (context , state){},
      builder: (context , state)
      {
        return  ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState  ,
          builder: (context)=>  ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context , index) => buildListProduct(ShopAppCubit.get(context).favoritesModel.faveData.dataList[index], context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: ShopAppCubit.get(context).favoritesModel.faveData.dataList.length ,
          ),
          fallback:(context)=> Center(child: CircularProgressIndicator()),
        ) ;
      },
    ) ;
  }

  Widget buildListProduct( model , context )=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children:
          [
            Image(
              image: NetworkImage(model.dataProduct.image),
              width:120.0,
              height: 120.0,
            ),
            if(model.dataProduct.discount != 0)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0) ,
                  color: Colors.redAccent,
                ),
                padding: EdgeInsets.symmetric(horizontal: 5.0 , ),

                child: Text(
                  'DISCOUNT' ,
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
              )
          ],
        ),
        SizedBox(width: 10.0,) ,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.dataProduct.name ,
                style: TextStyle(
                  fontSize: 15.0 ,

                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              SizedBox(height: 20.0,) ,
              Row(
                children: [
                  Text(
                    '${model.dataProduct.price}' ,
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ) ,
                  SizedBox(width: 3.0,) ,
                  if(model.dataProduct.discount != 0)
                    Text(
                      '${model.dataProduct.oldPrice}' ,
                      style: TextStyle(
                          color: Colors.grey ,
                          decoration: TextDecoration.lineThrough ,
                          fontSize: 12.0
                      ),
                    ) ,
                  Spacer() ,
                  CircleAvatar(
                    radius: 15.0 ,
                    backgroundColor: ShopAppCubit.get(context).favorites[model.dataProduct.productId] ? Colors.blue : Colors.grey,
                    child: IconButton(
                        color: Colors.white,
                        iconSize: 14.0,
                        onPressed:()
                        {
                          ShopAppCubit.get(context).changeFavorites(model.dataProduct.productId) ;
                        },
                        icon: Icon(Icons.favorite_border_outlined)),
                  ) ,
                ],
              ) ,
            ],
          ),
        ) ,
      ],
    ),
  ) ;
}
