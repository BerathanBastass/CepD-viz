
import 'package:cepdovizapp/feature/settings/news/cubit/news_repository.dart';
import 'package:cepdovizapp/feature/settings/news/cubit/news_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




class NewsCubit extends Cubit<NewsState> {
  final NewsRepository _newsRepository;

  NewsCubit(this._newsRepository) : super(NewsInitialState());

  void fetchNews() async {
    try {
      emit(NewsLoadingState());
      final newsList = await _newsRepository.getNews();
      emit(NewsLoadedState( newsList: []));
    } catch (e) {
      emit(NewsErrorState(error: e.toString()));
    }
  }
}
