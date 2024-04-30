abstract class TradeState {}

class TradeInitial extends TradeState {}

class TradeLoaded extends TradeState {
  final Map<String, dynamic> tradeData;

  TradeLoaded(this.tradeData);
}

class TradeError extends TradeState {
  final String errorMessage;

  TradeError(this.errorMessage);
}
