class RestaurantModel {
  final String id;
  final String name;
  final String thumbUrl;
  final List<String> tags;
  final double ratings;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;

  const RestaurantModel({
    required this.id,
    required this.name,
    required this.thumbUrl,
    required this.tags,
    required this.ratings,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
  });

  RestaurantModel copyWith({
    String? id,
    String? name,
    String? thumbUrl,
    List<String>? tags,
    double? ratings,
    int? ratingsCount,
    int? deliveryTime,
    int? deliveryFee,
  }) {
    return RestaurantModel(
      id: id ?? this.id,
      name: name ?? this.name,
      thumbUrl: thumbUrl ?? this.thumbUrl,
      tags: tags ?? this.tags,
      ratings: ratings ?? this.ratings,
      ratingsCount: ratingsCount ?? this.ratingsCount,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      deliveryFee: deliveryFee ?? this.deliveryFee,
    );
  }
}
