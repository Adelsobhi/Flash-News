import 'dart:convert';

import 'package:flash_news/api/api_constants.dart';
import 'package:flash_news/api/end_points.dart';
import 'package:flash_news/model/SourceResponse.dart';
import 'package:flash_news/model/newsResponse.dart';
import 'package:http/http.dart' as http;

class ApiManager {
  //           https://newsapi.org/v2/top-headlines/sources?apiKey=9879cbb421f146d4aa63abdb0d55a0e9
  static Future<SourceResponse> getSources(String categoryId)async{
    Uri url=Uri.https(
        ApiConstants.baseUrl,
        EndPoints.sourceApi,
    {'apiKey':ApiConstants.apiKey,
      'category':categoryId
    });
   try {
     var response = await http.get(url);
     var responseBody = response.body;
     var json = jsonDecode(responseBody);
    return  SourceResponse.fromJson(json);
   }catch(e){
     throw e ;
   }
  }
  //           https://newsapi.org/v2/everything?q=bitcoin&apiKey=9879cbb421f146d4aa63abdb0d55a0e9
  static Future<NewsResponse?> getNewsBySourceId(String sourceId) async{
    Uri url=Uri.https(
        ApiConstants.baseUrl,
      EndPoints.newsApi,
      {
         'apiKey':ApiConstants.apiKey,
        'sources':sourceId
      }
    );
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return NewsResponse.fromJson(json);
    }catch (e){
      throw e;
    }
  }
}

