
abstract class CurrencyConverterEvent {}

class ConvertCurrency extends CurrencyConverterEvent {
  final double amount;
  final String selectedCurrency;

  ConvertCurrency({required this.amount, required this.selectedCurrency});
}


