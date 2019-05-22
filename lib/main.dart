import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' as JSON;
import 'package:flutter_json/model/ingredients.dart';
import 'package:flutter_json/view/detail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ListView Data JSON',
      home: IngredientsPage(),
    );
  }
}

class IngredientsPage extends StatefulWidget {
  IngredientsPage({Key key}) : super(key: key);

  @override
  _IngredientsPageState createState() => _IngredientsPageState();
}

class _IngredientsPageState extends State<IngredientsPage> {

  List<Ingredients> ingredients = [];

  loadData() async {
    String dataURL = "https://www.themealdb.com/api/json/v1/1/list.php?i=list";

    http.Response response = await http.get(dataURL);
    var responseJson = JSON.jsonDecode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        ingredients = (responseJson['meals'] as List)
            .map((p) => Ingredients.fromJson(p))
            .toList();
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }

  //load awal
  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView Data JSON'),
      ),

      body: getBody()
    );
  }

  getBody() {
    if (ingredients.length == 0) {
      return new Center(child: new CircularProgressIndicator());
    } else {
      return getListView();
    }
  }

  ListView getListView() => ListView.builder(
    itemCount: ingredients.length,
      itemBuilder: (BuildContext context, int i){
        return getRow(i);
      }
  );

  Widget getRow(int i) {
    return new GestureDetector(
        child: new Padding(
            padding: new EdgeInsets.all(10.0),
            child: new Text("${ingredients[i].strIngredient}")),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      IngredientsDetailPage(ingredients: ingredients[i])));
        });
  }
}
