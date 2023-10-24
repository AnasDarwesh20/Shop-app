class ShopLoginModel
{
   bool status ;
   String message ;
   UserData data ;

  ShopLoginModel.fromJason(Map <String , dynamic > jason )
  {
    status = jason['status'] ;
    message = jason['message'] ;
    if (jason['data'] != null)
    {
      data = UserData.formJason(jason ['data']);
    }
  }

}


class ShopLoginModelError
{
   bool status ;
   String message ;
   UserData data ;

  ShopLoginModelError.fromJason(Map <String , dynamic > jason )
  {
    status = jason['status'] ;
    message = jason['message'] ;
  }

}
class UserData
{
   int id ;
   String name ;
   String email ;
   String phone ;
   String image ;
   int points  ;
   int credit  ;
   String token  ;

  UserData.formJason(Map<String , dynamic > jason)
  {
    id = jason ['id'] ;
    name  = jason['name'];
     email = jason['email'];
     phone = jason['phone'];
     image = jason['image'];
     points = jason['points'] ;
     credit  = jason['credit'];
    token  = jason['token'];
  }
}