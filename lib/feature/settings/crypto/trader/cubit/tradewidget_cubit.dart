import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import 'tradewidget_state.dart';

class TradeCubit extends Cubit<TradeState> {
  TradeCubit() : super(TradeInitial());


  Future<void> fetchTradeData(String id) async {
    try {
      var dio = Dio();
      var response = await dio.get('https://api.coincap.io/v2/assets/$id');

      if (response.statusCode == 200) {
        emit(TradeLoaded(response.data['data']));
      } else {
        emit(TradeError('Failed to load trade data'));
      }
    } catch (e) {
      emit(TradeError('Error fetching trade data: $e'));
    }
  }
}
