




import 'package:equatable/equatable.dart';

class NewsItem {
  final String title;
  final String description;
  final String date;
  final String imageUrl;

  NewsItem({
    required this.title,
    required this.description,
    required this.date,
    required this.imageUrl,
  });

  factory NewsItem.fromMap(Map<String, dynamic> map) {
    return NewsItem(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      date: map['date'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }
}


abstract class NewsState extends Equatable {
  const NewsState();

  List<Object> get props => [];
}


class NewsInitialState extends NewsState {}


class NewsLoadingState extends NewsState {}


class NewsLoadedState extends NewsState {
  final List<NewsItem> newsList;

  const NewsLoadedState({required this.newsList});

  @override
  List<Object> get props => [newsList];
}


class NewsErrorState extends NewsState {
  final String error;

  const NewsErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
