
import 'package:cepdovizapp/feature/conversion/cubit/currency_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forex_conversion/forex_conversion.dart';

class CurrencyConverterCubit extends Cubit<CurrencyConverterState> {
  final Forex fx = Forex();

  CurrencyConverterCubit() : super(CurrencyConverterInitial());

  void convertCurrency(double amount, String selectedCurrency) async {
    try {
      emit(CurrencyConverterLoading());
      final Map<String, double> prices = await fx.getAllCurrenciesPrices();
      final double selectedCurrencyRate = prices[selectedCurrency] ?? 1.0;
      final double usdAmount = amount * selectedCurrencyRate;
      final double tryAmount = amount / selectedCurrencyRate;
      final double tryToSelectedRate = prices['TRY'] ?? 1.0;
      final double tryToSelectedAmount = tryAmount * tryToSelectedRate;
      emit(CurrencyConverterLoaded(usdAmount: usdAmount, convertedAmount: tryToSelectedAmount));
    } catch (e) {
      print('Error converting currency: $e');
      emit(CurrencyConverterError());
    }
  }
}
