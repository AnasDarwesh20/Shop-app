
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:shop_app/models/shop_model/favorites_model.dart';
import 'package:shop_app/shop_layout/cubit/cubit.dart';

Widget defaultFormField({
  @required TextInputType textInputType,
  @required dynamic function,
  dynamic onTap,
  @required IconData prefixIcon,
  @required TextEditingController controller,
  @required String lable,
  var onSubmit,
  bool isPasswordShown = false,
  @required IconData suffixIcon,
}) =>
    TextFormField(
      onFieldSubmitted: onSubmit,
      controller: controller,
      obscureText: isPasswordShown,
      decoration: InputDecoration(
        labelText: lable,
        fillColor: Colors.white,
        prefixIcon: Icon(
          prefixIcon,
        ),
        suffixIcon: GestureDetector(
          onTap: onTap,
          child: Icon(
            suffixIcon,
          ),
        ),
        border: OutlineInputBorder(),
      ),
      validator: function,
    );

Widget butomn({
  double width = double.infinity,
  Color background = Colors.blue,
  @required String text,
  bool isUpper = true,
  double radius = 15.0,
  @required final VoidCallback function,
}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpper ? text.toUpperCase() : text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

Widget appBar() => AppBar(
      toolbarHeight: 100.0,
      title: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "WhatsApp",
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Icon(
                  Icons.camera_alt,
                  color: Colors.white60,
                ),
                SizedBox(
                  width: 40.0,
                ),
                Text(
                  "CHATS",
                  style: TextStyle(fontSize: 15.0),
                ),
                SizedBox(
                  width: 40.0,
                ),
                Text(
                  "STATUS",
                  style: TextStyle(fontSize: 15.0),
                ),
                SizedBox(
                  width: 35.0,
                ),
                Text(
                  "CALLS",
                  style: TextStyle(fontSize: 15.0),
                ),
                SizedBox(
                  width: 5.0,
                ),
                CircleAvatar(
                  backgroundColor: Colors.white60,
                  radius: 10.0,
                  child: Text(
                    "4",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.green[400],
      actions: [
        Padding(
          padding: const EdgeInsets.only(bottom: 35.0),
          child: Row(
            children: [
              Icon(
                Icons.search,
              ),
              SizedBox(
                width: 8.0,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Icon(
                  Icons.menu,
                ),
              ),
            ],
          ),
        ),
      ],
    );




Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 10.0,
        end: 10.0,
      ),
      child: Container(
        height: 1.0,
        width: double.infinity,
        color: Colors.grey[300],
      ),
    );




void navigateTo(context, Widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Widget,
    ));

void navigateToAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (Route<dynamic> route) => false,
    );

void showToast({
  @required String message,
  @required ToastStates states,
}) =>
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: shooseToastColor(states),
      textColor: Colors.white,
      fontSize: 16.0,
    );


enum ToastStates { SUCCESS, ERROR, WARNING }

Color shooseToastColor(ToastStates states) {
  Color color;
  switch (states) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget buildListProduct(DataProduct model, context, {bool isOldPrice = true}) =>
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


Widget defultAppBar({
  @required BuildContext context,
  String title,
  List<Widget> actions,
}) => AppBar(
  elevation: 0.0,
  titleSpacing: 1.0,
  leading: IconButton(
    color: Colors.black,
      icon : Icon(
          IconBroken.Arrow___Left_2 ,
      ),
    onPressed: ()
    {
      Navigator.pop(context) ;
    },
  ) ,
  title: Text(
      '${title}' ,
  ),
  actions: actions,
) ;

