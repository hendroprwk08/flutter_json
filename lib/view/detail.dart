import 'package:flutter/material.dart';
import 'package:flutter_json/model/ingredients.dart';

class IngredientsDetailPage extends StatelessWidget {

  Ingredients ingredients;

  IngredientsDetailPage({Key key, @required this.ingredients})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Detail Ingredients"),
        ),
        body: getBody());
  }

  getBody() {
    return new ListView(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            "${ingredients.strIngredient}",
            softWrap: true,
          ),
        )
      ],
    );
  }
}


