import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news_app/core/models/news_model/news_model.dart';

class Firestore {
  static Future<List<NewsModel>> getAllNews() async {
    return (await FirebaseFirestore.instance.collection('news').get())
        .docs
        .map((item) => NewsModel.fromJson(item.data()))
        .toList();
  }

  static Future addNews(String documentId, Map<String, dynamic> data) async {
    // Timer(const Duration(milliseconds: 500), () async {
    try {
      await FirebaseFirestore.instance
          .collection("news")
          .doc(documentId)
          .set(data);
    } catch (e) {
      print(e.toString());
    }

    // });
  }

  static Future<void> uploadNewsToFirebase(
      List<NewsModel> newsList) async {
    var collection = FirebaseFirestore.instance.collection('news');
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      doc.reference.delete();
    }
   
    for (NewsModel newsItem in newsList) {
      await FirebaseFirestore.instance.collection('news').add({
        'likes': [],
        'category': newsItem.category,
        'content': newsItem.content,
        'description': newsItem.description,
        'publishedAt': newsItem.publishedAt,
        // 'source': newsItem.source,
        'title': newsItem.title,
        'url': newsItem.url,
        'urlToImage': newsItem.urlToImage,

      });
    }

    final snapShot = await FirebaseFirestore.instance.collection('news').get();
    Future<void> removeDuplicated(List<NewsModel> newsList) async {
      // while(snapShot.)
    }
    print(snapShot.docs.length);
    print("all items added to firebase");
  }

  static Future addOrUpdateWithId(
      String collection, String documentId, Map<String, dynamic> data) async {
    // Timer(const Duration(milliseconds: 500), () async {
    await FirebaseFirestore.instance
        .collection(collection)
        .doc(documentId)
        .update(data);
    // });
  }
}
