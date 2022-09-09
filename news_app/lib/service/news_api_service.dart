import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/model/news_model.dart';

//https://newsapi.org/v2/everything?q=bitcoin&apiKey=1039e6f90e5a4cb2a6193bcb7a1127b4&sortBy=popularity&pageSize=5
class NewsApiService {
/*  Future getAllnews() async {
    var link = Uri.https(baseUrl, "/v2/everything", {
      "q": "bitcoin",
    });
    var link2 = "https://newsapi.org/v2/everything?q=bitcoin&apiKey";
    print("sddddddddddddddddddddddddd");
    var responce =
        await http.get(Uri.parse(link2), headers: {"X-Api-Key": apiKey});

    print("responce isssssssssss${responce.body}");
  }*/

  static Future<List<Articles>> fetchNewsData(
      // {required int page, required String sortBy}
      ) async {
    List<Articles> newsList = [];
    var link = Uri.parse(
        "https://newsapi.org/v2/everything?q=bitcoin&apiKey=2411956f83c949a9b92d8c5f63a81ee6&pageSize=5");

    var responce = await http.get(link);
    print("responce is ${responce.body}");
    var data = jsonDecode(responce.body);
    Articles articles;
    for (var i in data["articles"]) {
      articles = Articles.fromJson(i);
      newsList.add(articles);
    }
    return newsList;
  }
}
