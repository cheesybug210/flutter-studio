import 'dart:convert';

import 'package:flutter/material.dart';
import 'menu_data.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application name
      title: 'Studio - Flutter',
      // Application theme data, you can set the colors for the application as
      // you want
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      // A widget which will be started on application startup
      home: MyHomePage(title: 'My Bakery'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _cocktails = <Cocktail>[];
  var _alcohol = "";

  void _setAlcohol(String alcohol) {
    setState(() {
      _alcohol = alcohol;
    });
  }

  void _setCocktails(List<Cocktail> cocktails) {
    setState(() {
      _cocktails = cocktails;
    });
  }

  @override
  Widget build(BuildContext context) {
    const ingredients = ["vodka", "gin", "tequila"];
    return Scaffold(
        appBar: AppBar(
          // The title text which will be shown on the action bar
          title: Text(widget.title),
        ),
        // body with a row of buttons followed by a column of menuitems
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (var ingredient in ingredients)
                  ElevatedButton(
                      onPressed: () async {
                        _setCocktails(await fetchCocktails(ingredient));
                        _setAlcohol(ingredient);
                      },
                      child: Text(ingredient))
              ],
            ),
            Text('Current alcohol: $_alcohol'),
            Expanded(
                child: ListView.builder(
                    itemCount: _cocktails.length,
                    itemBuilder: (context, index) => MenuItem(
                          name: _cocktails[index].name,
                          // price: menuItems[index]['price'] ?? "",
                          // description: menuItems[index]['description'] ?? "",
                          imageUrl: _cocktails[index].image,
                        )))
          ],
        ));
    // body: ListView.builder(
    //     itemCount: menuItems.length,
    //     itemBuilder: (context, index) => MenuItem(
    //           name: menuItems[index]['name'] ?? "",
    //           price: menuItems[index]['price'] ?? "",
    //           description: menuItems[index]['description'] ?? "",
    //           imageUrl: menuItems[index]['imageUrl'] ?? "",
    //         ))
  }
}

class MenuItem extends StatelessWidget {
  final String name;
  // final String price;
  // final String description;
  final String imageUrl;

  const MenuItem({
    Key? key,
    required this.name,
    // required this.price,
    // required this.description,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
      child: Row(
        children: [
          Image.network(imageUrl, width: 100, height: 100),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(fontSize: 20)),
                // Text(price, style: TextStyle(fontSize: 16)),
                // Text(description, style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Cocktail {
  final String name;
  final String image;

  const Cocktail({
    required this.name,
    required this.image,
  });

  factory Cocktail.fromJson(Map<String, String> json) {
    return Cocktail(
      name: json['strDrink'] ?? "",
      image: json['strDrinkThumb'] ?? "",
    );
  }
}

Future<List<Cocktail>> fetchCocktails(String alc) async {
  final response = await http.get(
      Uri.parse('https://thecocktaildb.com/api/json/v1/1/filter.php?i=$alc'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<Cocktail> cocktails = jsonDecode(response.body)['drinks']
        .map<Cocktail>(
            (json) => Cocktail.fromJson(Map<String, String>.from(json as Map)))
        .toList();

    return cocktails;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
