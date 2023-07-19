class RestaurantsResult {
  final List<ListRestaurant> restaurants;

  RestaurantsResult({
    required this.restaurants,
  });

  factory RestaurantsResult.fromJson(Map<String, dynamic> json) =>
      RestaurantsResult(
        restaurants: List<ListRestaurant>.from(
            json["restaurants"].map((x) => ListRestaurant.fromJson(x))),
      );
}

class ListRestaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;

  ListRestaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory ListRestaurant.fromJson(Map<String, dynamic> json) => ListRestaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };
}
