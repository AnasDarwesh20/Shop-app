import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_model/search_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shop_app/search/cubit/cubit.dart';
import 'package:shop_app/shop_app/search/cubit/states.dart';
import 'package:shop_app/shop_layout/cubit/cubit.dart';

class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  defaultFormField(
                    textInputType: TextInputType.name,
                    function: (String value) {
                      if (value.isEmpty) {
                        return 'search for something';
                      }
                      return null;
                    },
                    onSubmit: (String text) {
                      SearchCubit.get(context).search(text: text);
                    },
                    prefixIcon: Icons.search,
                    controller: searchController,
                    lable: 'Search',
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  if (state is SearchLoadingState) LinearProgressIndicator(),
                  SizedBox(
                    height: 10.0,
                  ),
                  if (state is SearchLoadingSuccessState)
                    Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => buildGridProduct(
                            SearchCubit.get(context)
                                .searchModel
                                .faveData
                                .dataList[index],
                            context,
                            false),
                        separatorBuilder: (context, index) => myDivider(),
                        itemCount: SearchCubit.get(context)
                            .searchModel
                            .faveData
                            .dataList
                            .length,
                      ),
                    )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildGridProduct(DataProduct model, context, bool isOldPrice) =>
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: 120.0,
                  height: 120.0,
                ),
                if (model.discount != 0 && isOldPrice)
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.redAccent,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
              ],
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price}',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(
                        width: 3.0,
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Text(
                          '${model.oldPrice}',
                          style: TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                              fontSize: 12.0),
                        ),
                      Spacer(),
                      CircleAvatar(
                        radius: 15.0,
                        backgroundColor:
                            ShopAppCubit.get(context).favorites[model.productId]
                                ? Colors.blue
                                : Colors.grey,
                        child: IconButton(
                            color: Colors.white,
                            iconSize: 14.0,
                            onPressed: () {
                              ShopAppCubit.get(context)
                                  .changeFavorites(model.productId);
                            },
                            icon: Icon(Icons.favorite_border_outlined)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
