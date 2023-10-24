import 'dart:core';

class HomeModel
{

   bool status ;
   HomeDataModel data ;

  HomeModel.fromJason(Map<String , dynamic> jason)
  {
    status = jason['status'] ;
    data = HomeDataModel.fromJason(jason['data']) ;
  }
}

class HomeDataModel
{
  List <BannerModel> banners = []  ;
  List <ProductModel> products = [];

  HomeDataModel.fromJason(Map<String , dynamic> jason)
  {
    jason['banners'].forEach((element)
    {
      banners.add(BannerModel.fromJason(element)) ;  //i should convert the elements into banner model
    });

    jason['products'].forEach((element)
    {
      products.add(ProductModel.fromJason(element)) ;
    });
  }
}
class BannerModel
{
   int id ;
   String image ;
  BannerModel.fromJason(Map<String , dynamic> jason)
  {
    image = jason['image'] ;
    id = jason['id'] ;
  }
}
class ProductModel
{
   int id ;
   dynamic price ;
   dynamic oldPrice ;
   dynamic discount ;
   String image ;
   String name ;
   bool inFavorites ;
   bool inCart ;
  ProductModel.fromJason(Map<String , dynamic> jason)
  {
    id = jason['id'] ;
    price = jason['price'] ;
    oldPrice = jason['old_price'] ;
    discount = jason['discount'] ;
    image = jason['image'] ;
    name = jason['name'] ;
    inFavorites = jason['in_favorites'] ;
    inCart = jason['in_cart'] ;
  }
}