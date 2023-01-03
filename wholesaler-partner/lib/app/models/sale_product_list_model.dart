class SaleProductListModel {
  final int id;

  final int storeId;

  final String storeName;

  final String productName;

  final int price;

  final String imageUrl;

  final int totalCount;

  SaleProductListModel(
      {required this.id,
      required this.storeId,
      required this.storeName,
      required this.productName,
      required this.price,
      required this.imageUrl,
      required this.totalCount});

  factory SaleProductListModel.fromJson(Map<String, dynamic> data) {
    return SaleProductListModel(
        id: data['id'],
        storeId: data['store_id'],
        storeName: data['store_name'],
        productName: data['product_name'],
        price: data['price'],
        imageUrl: data['thumbnail_image_url'],
        totalCount: data['total_count']);
  }

  static List<SaleProductListModel> fromJsonList(List<dynamic> products) {
    List<dynamic> tempList = products;
    List<SaleProductListModel> productList = [];
    tempList.forEach((element) {
      productList.add(SaleProductListModel.fromJson(element));
    });

    return productList;
  }
}
