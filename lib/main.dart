import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(new MaterialApp(

  home: new HomePage(),
  theme: ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blueGrey,
    ),
  ),
)
);

//stateful for HomePage - online data fetching
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final String url = "https://jsonplaceholder.typicode.com/posts";
  List? data;

  //override initState method
  @override
  void initState(){
    super.initState();

    //load json data
    this.getJsonData();
  }

  //to get json data
  Future<void> getJsonData() async{

    var response = await http.get(
      //encode the url
      Uri.parse(url),
      //only accept json response
      headers: {"Accept": "application/json"}
    );

    print(response.body);

    setState(() {
      // var convertDataToJson = JsonDecoder().convert(response.body);
      //decode JSON data directly to the list
      data = json.decode(response.body);
    });

  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Online Fetching JSON data"),
      ),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data?.length,
          itemBuilder: (BuildContext context, int index){
            return new Container(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    new Card(
                      child: Container(
                        child: new Container(
                          child: Column(
                            children: [
                              Text("User ID: "+data![index]['userId'].toString()),
                              Text("ID: "+data![index]['id'].toString()),
                              Text("Title: "+data?[index]['title']),
                              Text("Paragraph: "+data?[index]['body']),
                            ],
                          ),
                        ),
                        padding: EdgeInsets.all(10.0),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}
