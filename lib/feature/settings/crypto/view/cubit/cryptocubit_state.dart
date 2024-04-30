abstract class CryptoState {}

class CryptoInitial extends CryptoState {}

class CryptoLoading extends CryptoState {}

class CryptoLoaded extends CryptoState {
  final List<dynamic> cryptoList;

  CryptoLoaded(this.cryptoList);
}

class CryptoError extends CryptoState {
  final String errorMessage;

  CryptoError({required this.errorMessage});
}
