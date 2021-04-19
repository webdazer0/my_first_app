import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(
    MaterialApp(
      home: HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  String baseUrl = 'https://librojs.herokuapp.com/api/books';
  List data;
  List booksData;

  getBooks() async {
    http.Response response = await http.get(Uri.parse(baseUrl));
    data = json.decode(response.body);
    // debugPrint(response.body);
    setState(() {
      booksData = data;
    });
  }

  @override
  void initState() {
    super.initState();
    getBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Webdazer0 Appbar'),
      ),
      body: ListView.builder(
          itemCount: booksData == null ? 0 : booksData.length,
          itemBuilder: (BuildContext context, int i) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "$i",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w500),
                      ),
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage(booksData[i]["imageThumb"]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("${booksData[i]["title"]}", style: TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.w700
                      ),),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
