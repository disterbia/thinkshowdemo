class Item {
	String? productName;
	String? productOptionName;
	String? productThumbnailImagePath;
	int? qty;
	int? price;
	int? addPrice;
	int? amount;

	Item({
		this.productName, 
		this.productOptionName, 
		this.productThumbnailImagePath, 
		this.qty, 
		this.price, 
		this.addPrice, 
		this.amount, 
	});

	factory Item.fromJson(Map<String, dynamic> json) => Item(
				productName: json['product_name'] as String?,
				productOptionName: json['product_option_name'] as String?,
				productThumbnailImagePath: json['product_thumbnail_image_path'] as String?,
				qty: json['qty'] as int?,
				price: json['price'] as int?,
				addPrice: json['add_price'] as int?,
				amount: json['amount'] as int?,
			);

	Map<String, dynamic> toJson() => {
				'product_name': productName,
				'product_option_name': productOptionName,
				'product_thumbnail_image_path': productThumbnailImagePath,
				'qty': qty,
				'price': price,
				'add_price': addPrice,
				'amount': amount,
			};
}
