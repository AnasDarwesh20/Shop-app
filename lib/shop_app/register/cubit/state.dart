
import 'package:shop_app/models/shop_model/shop_login_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterLodingState extends ShopRegisterStates {}

class ShopRegisterInitialState extends ShopRegisterStates {}

class ShopRegisterSucessState extends ShopRegisterStates
{
  final ShopLoginModel loginModel ;

  ShopRegisterSucessState(this.loginModel);
}

class ShopRegisterErrorState extends ShopRegisterStates
{
  final error ;
  ShopRegisterErrorState(this.error);
}