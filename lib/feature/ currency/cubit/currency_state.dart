abstract class CurrencyListState {}

class CurrencyListLoadingState extends CurrencyListState {}

class CurrencyListErrorState extends CurrencyListState {}

class CurrencyListLoadedState extends CurrencyListState {
  final Map<String, double> exchangeRates;
  final List<String> filteredCurrencies;

  CurrencyListLoadedState({
    required this.exchangeRates,
    required this.filteredCurrencies,
  });
}

class CurrencyListFavoriteLoadedState extends CurrencyListState {
  final Map<String, bool> favoriteMap;

  CurrencyListFavoriteLoadedState(this.favoriteMap);
}

class CurrencyListFilteredState extends CurrencyListState {
  final List<String> filteredCurrencies;

  CurrencyListFilteredState(this.filteredCurrencies);
}

class CurrencyListFavoriteUpdatedState extends CurrencyListFavoriteLoadedState {
  CurrencyListFavoriteUpdatedState(Map<String, bool> favoriteMap) : super(favoriteMap);
}
