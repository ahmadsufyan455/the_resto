import 'dart:convert';

class Restaurant {
  late String id;
  late String name;
  late String description;
  late String pictureId;
  late String city;
  late double rating;
  late Menu menu;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menu,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      pictureId: json['pictureId'],
      city: json['city'],
      rating: json['rating'] * 1.0,
      menu: Menu.fromJson(json['menus']),
    );
  }
}

List<Restaurant> parseRestaurant(String? json) {
  if (json == null) return [];
  final List parsed = jsonDecode(json)['restaurants'];
  return parsed.map((json) => Restaurant.fromJson(json)).toList();
}

class Menu {
  List<Food> foods;
  List<Drink> drinks;

  Menu({required this.foods, required this.drinks});

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      foods: List<Food>.from(
        json['foods'].map(
          (food) => Food.fromJson(food),
        ),
      ),
      drinks: List<Drink>.from(
        json['drinks'].map(
          (drink) => Drink.fromJson(drink),
        ),
      ),
    );
  }
}

class Food {
  late String name;

  Food({required this.name});

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(name: json['name']);
  }
}

class Drink {
  late String name;

  Drink({required this.name});

  factory Drink.fromJson(Map<String, dynamic> json) {
    return Drink(name: json['name']);
  }
}
