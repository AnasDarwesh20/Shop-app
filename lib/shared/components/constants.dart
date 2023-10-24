
import 'package:shop_app/network/local/cash_helper.dart';
import 'package:shop_app/shop_app/login/login_shop_app.dart';

import 'components.dart';

void signOut (context){
  CacheHelper.removeData(key: 'token').then((value)
  {
    if(value)
    {
      navigateToAndFinish(context, ShopLoginScreen()) ;
    }
  }) ;
}

void printFullText(String text)
{
  final pattern = RegExp('.{1,800}') ;
  pattern.allMatches(text).forEach((match)=>print(match.group(0))) ;
}

String token = '' ;
String uId = '' ;
//..................................commands......................................
    // ./gradlew signingReport