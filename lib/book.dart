import 'package:flutter/material.dart';
import 'langmanager.dart';

class Book extends StatefulWidget {
  @override
  _BookState createState() => _BookState();
}

class _BookState extends State<Book> {

  Map data = {};
  String lang = "EN";
  List<String> images = [
    'https://i.imgur.com/RVbUfZU.png',
    'https://i.imgur.com/BnVPif7.png',
    'https://i.imgur.com/sVFKc7I.png',
    'https://i.imgur.com/ulXlpU4.png',
    'https://i.imgur.com/HOJ2alw.png',
    'https://i.imgur.com/oOsTTlc.png',
  ];

  Card getCard(int index) => Card(
      child: Column(
        children: [
          Center(child: Text(LM.t[lang]['TIP${index}T'], style : TextStyle(fontSize: 20))),
          Center(child: Text(LM.t[lang]['TIP$index'])),
          SizedBox(height: 10,),
          Center(child: Image.network(images[index-1])),
        ],
      )
  );

  List<Card> getCardList() {
    List<Card> cards = List();
    for (int i = 1; i <= images.length; i++) {
      cards.add(getCard(i));
    }
    return cards;
  }


  @override
  Widget build(BuildContext context) {

    data = ModalRoute.of(context).settings.arguments;
    lang = data['lang'];

    return Scaffold(
      appBar: AppBar(title: Text(LM.t[lang]['TIP'])),
      body: ListView(
        children: getCardList()
      )
    );
  }
}

