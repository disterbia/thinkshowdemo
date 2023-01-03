class ImageBannerModel {
  late int id;
  late String banner_img_url;

  ImageBannerModel({required this.id, required this.banner_img_url});

  ImageBannerModel.fromJson(dynamic json) {
    id = json['id'];
    banner_img_url = json['banner_img_url'];
  }
}
