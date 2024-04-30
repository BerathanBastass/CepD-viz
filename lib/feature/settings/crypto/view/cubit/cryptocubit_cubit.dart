import 'package:cepdovizapp/feature/settings/crypto/view/cubit/cryptocubit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

class CryptoCubit extends Cubit<CryptoState> {
  CryptoCubit() : super(CryptoInitial());

  void updateCryptoData() async {
    emit(CryptoLoading());
    try {
      var dio = Dio();
      var response = await dio.get(
        'https://api.coincap.io/v2/assets',
      );

      if (response.statusCode == 200) {
        var responseBody = response.data;
        if (responseBody['data'] is List) {
          List<dynamic> cryptoList = responseBody['data'];
          emit(CryptoLoaded(cryptoList));
        } else {
          emit(CryptoError(errorMessage: 'Invalid API response format'));
        }
      } else {
        emit(CryptoError(errorMessage: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(CryptoError(errorMessage: 'Error fetching data: $e'));
    }
  }
}
