
import 'dart:convert';

import '../services/webservice.dart';
import '../utils/constants.dart';

class NewsArticle {
  
  final String name; 
  final String emailId; 
  final String urlToImage; 

  NewsArticle({required this.name, required this.emailId, required this.urlToImage});

  factory NewsArticle.fromJson(Map<String,dynamic> json) {
    return NewsArticle(
      name: json['first_name'] + json['last_name'], 
      emailId: json['email'], 
      urlToImage: json['avatar'] ?? Constants.NEWS_PLACEHOLDER_IMAGE_ASSET_URL
    );
  
}

  static Resource<List<NewsArticle>> get all {
    
    return Resource(
      url: Constants.HEADLINE_NEWS_URL,
      parse: (response) {
        final result = json.decode(response.body); 
        Iterable list = result['data'];
        return list.map((model) => NewsArticle.fromJson(model)).toList();
      }
    );

  }

}