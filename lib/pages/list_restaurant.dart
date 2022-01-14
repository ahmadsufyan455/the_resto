import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:the_resto/model/restaurant.dart';
import 'package:the_resto/pages/detail_restaurant.dart';
import 'package:the_resto/utils/box_color.dart';

class ListRestaurantPage extends StatefulWidget {
  static const routeName = 'list_restaurant';
  const ListRestaurantPage({Key? key}) : super(key: key);

  @override
  _ListRestaurantPageState createState() => _ListRestaurantPageState();
}

class _ListRestaurantPageState extends State<ListRestaurantPage> {
  Icon customIcon = const Icon(Icons.search);
  Widget appBarTitle = const Text('The Resto');

  TextEditingController searchController = TextEditingController();
  String filter = '';

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {
        filter = searchController.text;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBarTitle,
        elevation: 0,
        actions: [
          IconButton(
            icon: customIcon,
            onPressed: () {
              setState(() {
                searchController.text = '';
                if (customIcon.icon == Icons.search) {
                  customIcon = const Icon(Icons.cancel);
                  appBarTitle = ListTile(
                    leading: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    title: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Cari restoran...',
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                        ),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                } else {
                  customIcon = const Icon(
                    Icons.search,
                    color: Colors.white,
                  );
                  appBarTitle = const Text('The Resto');
                }
              });
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 16.0,
              bottom: 6.0,
            ),
            child: Text(
              'Recommendation restaurant for you!',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: FutureBuilder<String>(
              future: DefaultAssetBundle.of(context)
                  .loadString('assets/local_restaurant.json'),
              builder: (context, snapshot) {
                final List<Restaurant> restaurants =
                    parseRestaurant(snapshot.data);
                if (snapshot.connectionState != ConnectionState.done) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.hasData) {
                    return restaurants
                            .where((restaurant) => restaurant.name
                                .toString()
                                .toLowerCase()
                                .contains(filter.toLowerCase()))
                            .isEmpty
                        ? Center(
                            child: Lottie.asset(
                              'assets/no_data.json',
                              width: 300,
                            ),
                          )
                        : ListView.builder(
                            itemCount: restaurants.length,
                            itemBuilder: (context, index) {
                              if (filter == '') {
                                return RestoCard(restaurants[index]);
                              } else if (restaurants[index]
                                  .name
                                  .toLowerCase()
                                  .contains(filter.toLowerCase())) {
                                return RestoCard(restaurants[index]);
                              } else {
                                return Container();
                              }
                            },
                          );
                  } else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RestoCard extends StatelessWidget {
  RestoCard(this.restaurant);
  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          DetailRestaurantPage.routeName,
          arguments: restaurant,
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 8.0,
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Hero(
                      tag: restaurant.pictureId,
                      child: Image.network(
                        restaurant.pictureId,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurant.name,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        restaurant.description.substring(0, 25) + '...',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      const SizedBox(height: 8.0),
                      Row(
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
