
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_model/categories_model.dart';
import 'package:shop_app/models/shop_model/products_model.dart';
import 'package:shop_app/shop_layout/cubit/cubit.dart';
import 'package:shop_app/shop_layout/cubit/states.dart';

class ProductsScreen extends StatelessWidget {

  var formKey = GlobalKey<ScaffoldState>() ;
  var gridKey = GlobalKey<FormState>() ;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit , ShopAppStates>(
      listener: (context ,state ){},
      builder: (context ,state )
      {
        return  ConditionalBuilder(
          condition: ShopAppCubit.get(context).homeModel != null &&  ShopAppCubit.get(context).categoriesModel != null,
          builder: (context) =>builderWidget(ShopAppCubit.get(context).homeModel , ShopAppCubit.get(context).categoriesModel , context) ,
          fallback: (context)=> Center(child: CircularProgressIndicator()),
        );
      },
    ) ;
  }

  Widget builderWidget(HomeModel model , CategoriesModel categoriesModel , context) => Form(
    key: formKey,
    child: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          CarouselSlider(
              items:model.data.banners.map((e) =>Image(
                image: NetworkImage('${e.image}'),
                width: double.infinity,
                fit: BoxFit.cover ,
              ) , ).toList() ,
              options: CarouselOptions(
                height: 300.0 ,
                initialPage: 0 ,
                enableInfiniteScroll: true ,
                reverse: false ,
                autoPlay: true ,
                autoPlayInterval: Duration (seconds: 3) ,
                autoPlayAnimationDuration: Duration(seconds: 1) ,
                autoPlayCurve: Curves.fastOutSlowIn ,
                scrollDirection: Axis.horizontal ,
                viewportFraction: 1.0 ,
              )) ,
          SizedBox(
            height : 10.0 ,
          ) ,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ' Categories ' ,
                  style: TextStyle(
                    fontSize: 25.0 ,
                  ),
                ) ,
                Container(
                  height: 100.0,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context , index)=> buildCategoryItem(categoriesModel.data.data[index]),
                    separatorBuilder: (context , index) => SizedBox(width: 10.0,),
                    itemCount:categoriesModel.data.data.length ,),
                ) ,
                SizedBox(
                  height : 30.0 ,
                ) ,
                Text(
                    'New Products' ,
                  style: TextStyle(
                    fontSize: 25.0 ,
                  ),
                ),
              ],
            ),
          ) ,
          SizedBox(
            height : 10.0 ,
          ) ,
          Container(
            color: Colors.grey[200],
            child: GridView.count(
              key: gridKey,
              shrinkWrap: true ,
              childAspectRatio: 1 / 0.93,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 3.0,
              crossAxisSpacing: 3.0,
              children : List.generate(
                model.data.products.length,
                    (index) => buildGridProduct(model.data.products[index] , context) ,
              ) ,

            ),
          ) ,
        ],
      ),
    ),
  );

  Widget buildCategoryItem(DataModel dataModel) =>Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children:
    [
      Image(
        image: NetworkImage('${dataModel.image}') ,
        width: 100.0,
        height: 100.0,


      ) ,
      Container(
        width: 100.0,
        color: Colors.black.withOpacity(.8),
        child: Text(
          dataModel.name  ,
          style: TextStyle(
              fontSize: 15.0 ,
              color: Colors.white
          ),
          textAlign: TextAlign.center,
          maxLines:1,
          overflow: TextOverflow.ellipsis,


        ),
      ) ,
    ],
  ) ;
  Widget buildGridProduct(ProductModel model , context )=>Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0) ,
    ),

    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children:
            [
              Image(
                image: NetworkImage(model.image),
                width: double.infinity,
                height: 200.0,
              ),
              if(model.discount != 0)
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.name}' ,
                  style: TextStyle(
                    fontSize: 15.0 ,

                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                SizedBox(height: 1.0,) ,
                Row(
                  children: [
                    Text(
                      '${model.price}' ,
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ) ,
                    SizedBox(width: 3.0,) ,
                    if(model.discount != 0)
                      Text(
                      '${model.oldPrice}' ,
                      style: TextStyle(
                        color: Colors.grey ,
                        decoration: TextDecoration.lineThrough ,
                        fontSize: 12.0
                      ),
                    ) ,
                    Spacer() ,
                    CircleAvatar(
                      radius: 15.0 ,
                      backgroundColor: ShopAppCubit.get(context).favorites[model.id] ? Colors.blue : Colors.grey,
                      child: IconButton(
                        color: Colors.white,
                        iconSize: 14.0,
                          onPressed:()
                          {
                            ShopAppCubit.get(context).changeFavorites(model.id) ;
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
