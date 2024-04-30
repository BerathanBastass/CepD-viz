
import 'package:cepdovizapp/feature/settings/news/cubit/news_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewsRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<NewsItem>> getNews() async {
    try {
      QuerySnapshot snapshot = await firestore.collection('news').get();
      List<NewsItem> newsList = snapshot.docs.map((doc) => NewsItem.fromMap(doc.data() as Map<String, dynamic>)).toList();
      return newsList;
    } catch (e) {
      throw Exception('Failed to fetch news: $e');
    }
  }
}
