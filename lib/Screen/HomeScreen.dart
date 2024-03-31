import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/NewsNodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Future<NewsModel> fetchNews () async{
    final String Url = "https://newsapi.org/v2/everything?q=tesla&from=2024-02-29&sortBy=publishedAt&apiKey=516e90ac475e413896db5ebc5962eb78";
    var response = await http.get(Uri.parse(Url));
    if(response.statusCode==200){
      final result = jsonDecode(response.body);
      return NewsModel.fromJson(result);
    }
    else{
      return NewsModel();
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News App"),
        centerTitle: true,
      ),

      body: FutureBuilder(future: fetchNews(), builder:(context, snapshot) {
        return ListView.builder(itemBuilder: (context, index) {
          return ListTile(
            
            title: Text("${snapshot.data!.articles![index].title}"),
            leading: Image.network("${snapshot.data!.articles![index].urlToImage}"),
          );
        },itemCount: snapshot.data!.articles!.length,);
      },),
    );
  }
}
