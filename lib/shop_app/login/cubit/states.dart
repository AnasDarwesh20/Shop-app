
import 'package:shop_app/models/shop_model/shop_login_model.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates {}

class ShopLoginLodingState extends ShopLoginStates {}

class ShopLoginSucessState extends ShopLoginStates
{
  final ShopLoginModel loginModel ;

  ShopLoginSucessState(this.loginModel);
}

class ShopLoginErrorState extends ShopLoginStates
{
  final error ;
  ShopLoginErrorState(this.error);
}

