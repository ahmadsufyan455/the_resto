import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:the_resto/model/restaurant.dart';
import 'package:the_resto/utils/box_color.dart';

class DetailRestaurantPage extends StatelessWidget {
  static const routeName = 'detail_restaurant';
  const DetailRestaurantPage({required this.restaurant});

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Hero(
                  tag: restaurant.pictureId,
                  child: Image.network(
                    restaurant.pictureId,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                restaurant.name,
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  BoxColor(Icons.location_on, Colors.blue),
                  const SizedBox(width: 8.0),
                  Text(
                    restaurant.city,
                    style: Theme.of(context).textTheme.overline,
                  ),
                  const SizedBox(width: 16.0),
                  BoxColor(Icons.star, Colors.green),
                  const SizedBox(width: 8.0),
                  Text(
                    restaurant.rating.toString(),
                    style: Theme.of(context).textTheme.overline,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ReadMoreText(
                restaurant.description,
                trimLines: 5,
                colorClickableText: Colors.white,
                moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                trimMode: TrimMode.Line,
                trimCollapsedText: 'Tampilkan lebih banyak',
                trimExpandedText: 'Tampilkan lebih sedikit',
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Daftar Makanan',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            const SizedBox(height: 8.0),
            Container(
              padding: const EdgeInsets.only(left: 16.0),
              child: SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: restaurant.menu.foods.length,
                  itemBuilder: (context, index) {
                    final List foods =
                        restaurant.menu.foods.map((food) => food.name).toList();
                    return Container(
                      margin: const EdgeInsets.only(right: 8.0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 6.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Text(
                          foods[index],
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Daftar Minuman',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            const SizedBox(height: 8.0),
            Container(
              padding: const EdgeInsets.only(left: 16.0),
              child: SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: restaurant.menu.drinks.length,
                  itemBuilder: (context, index) {
                    final List drinks = restaurant.menu.drinks
                        .map((drink) => drink.name)
                        .toList();
                    return Container(
                      margin: const EdgeInsets.only(right: 8.0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 6.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Text(
                          drinks[index],
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}

class BoxMenu extends StatelessWidget {
  BoxMenu({required this.foodName});

  final String foodName;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.green,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        child: Text(foodName),
      ),
    );
  }
}
