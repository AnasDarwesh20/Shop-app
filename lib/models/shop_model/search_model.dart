class SearchModel
{
  bool status  ;
  Data faveData ;

  SearchModel.fromJson(Map<String , dynamic>json)
  {
    status = json['status'] ;
    faveData = Data.fromJson(json['data']) ;
  }

}

class Data
{
  int currentIndex ;
  String firstPageUrl ;
  int from ;
  String lastPageUrl ;
  String path ;
  int perPage ;
  dynamic prevPageUrl ;
  int to ;
  int total ;

  List<DataProduct> dataList = [];

  Data.fromJson(Map<String , dynamic>json)
  {
    currentIndex = json['current_index'] ;
    firstPageUrl  = json['first_page_url '] ;
    from  = json['from'] ;
    lastPageUrl  = json['last_page_url'] ;
    path  = json['path'] ;
    perPage  = json['per_page'] ;
    prevPageUrl  = json['prev_page_url'] ;
    to  = json['to'] ;
    total  = json['total'] ;

    json['data'].forEach((element)
    {
      dataList.add(DataProduct.fromJson(element)) ;
    }) ;
  }
}



class DataProduct
{
  int productId ;
  dynamic price ;
  dynamic oldPrice ;
  dynamic discount ;
  String image ;
  String name ;
  String description ;
  DataProduct.fromJson(Map<String , dynamic>json )
  {
    productId = json['id'] ;
    price = json['price'] ;
    oldPrice = json['old_price'] ;
    discount = json['discount'] ;
    image = json['image'] ;
    name = json['name'] ;
    description = json['description'] ;
  }
}