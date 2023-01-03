import 'item.dart';

class CheckoutList {
	int? storeId;
	String? storeName;
	String? storeThumbnailImagePath;
	List<Item>? items;

	CheckoutList({
		this.storeId, 
		this.storeName, 
		this.storeThumbnailImagePath, 
		this.items, 
	});

	factory CheckoutList.fromJson(Map<String, dynamic> json) => CheckoutList(
				storeId: json['store_id'] as int?,
				storeName: json['store_name'] as String?,
				storeThumbnailImagePath: json['store_thumbnail_image_path'] as String?,
				items: (json['items'] as List<dynamic>?)
						?.map((e) => Item.fromJson(e as Map<String, dynamic>))
						.toList(),
			);

	Map<String, dynamic> toJson() => {
				'store_id': storeId,
				'store_name': storeName,
				'store_thumbnail_image_path': storeThumbnailImagePath,
				'items': items?.map((e) => e.toJson()).toList(),
			};
}
