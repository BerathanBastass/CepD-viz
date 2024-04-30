abstract class CurrencyConverterState {}

class CurrencyConverterInitial extends CurrencyConverterState {}

class CurrencyConverterLoading extends CurrencyConverterState {}

class CurrencyConverterLoaded extends CurrencyConverterState {
  final double usdAmount;
  final double convertedAmount;

  CurrencyConverterLoaded({required this.usdAmount, required this.convertedAmount});
}

class CurrencyConverterError extends CurrencyConverterState {}
