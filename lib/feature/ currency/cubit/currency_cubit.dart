import 'dart:convert';
import 'package:cepdovizapp/core%20/enums/applocalizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forex_conversion/forex_conversion.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'currency_state.dart';

class CurrencyListCubit extends Cubit<CurrencyListState> {
  late AppLocalizations appLocalizations;
  final Forex fx = Forex();

  CurrencyListCubit() : super(CurrencyListLoadingState());

  void init(AppLocalizations appLocalizations) {
    this.appLocalizations = appLocalizations;
    fetchCurrencyExchangeRates();
    loadFavorites();
  }

  void fetchCurrencyExchangeRates() async {
    try {
      final Map<String, double> allPrices = await fx.getAllCurrenciesPrices();
      emit(CurrencyListLoadedState(
        exchangeRates: allPrices,
        filteredCurrencies: allPrices.keys.toList(),
      ));
    } catch (e) {
      emit(CurrencyListErrorState());
    }
  }

  void loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final Map<String, bool> favoriteMap = Map<String, bool>.from(
      prefs.getString('favorites') != null
          ? json.decode(prefs.getString('favorites')!)
          : {},
    );
    emit(CurrencyListFavoriteLoadedState(favoriteMap));
  }

  void saveFavorites(Map<String, bool> favoriteMap) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('favorites', json.encode(favoriteMap));
  }

  void filterCurrencies(String searchText, Map<String, double> exchangeRates) {
    final List<String> filteredCurrencies = exchangeRates.keys.where((currency) =>
    currency.toLowerCase().contains(searchText.toLowerCase()) ||
        getFullCurrencyName(currency).toLowerCase().contains(searchText.toLowerCase())
    ).toList();

    final Map<String, double> filteredExchangeRates = { for (var currency in filteredCurrencies) currency : exchangeRates[currency]! };

    emit(CurrencyListFilteredState(filteredExchangeRates as List<String>));
  }

  void updateFavorite(String currency, bool isFavorite, Map<String, bool> favoriteMap) {
    favoriteMap[currency] = isFavorite;
    saveFavorites(favoriteMap);
    emit(CurrencyListFavoriteUpdatedState(favoriteMap));
  }

  Future<void> refreshList() async {
    fetchCurrencyExchangeRates();
  }

  String getFullCurrencyName(String currency) {
    switch (currency) {
      case 'USD':
        return 'Dolar';
      case 'NAD':
        return  "Namibya Doları";
      case 'GHS':
        return 'Gana Cedisi';
      case 'EGP':
        return 'Mısır Lirası';
      case 'BGN':
        return 'Bulgar Levası';
      case 'EUR':
        return 'Euro';
      case 'DZD':
        return 'Cezayir Dinarı';
      case 'GBP':
        return 'İngiliz Sterlini';
      case 'XCD':
        return 'Doğu Karayip Doları';
      case 'PAB':
        return 'Panama Balboası';
      case 'BOB':
        return 'Bolivya Bolivianosu';
      case 'DKK':
        return 'Danimarka Kronu ';
      case 'BWP':
        return 'Botsvana Pulası';
      case 'LBP':
        return 'Lübnan Lirası ';
      case 'TZS':
        return 'Tanzanya Şilini ';
      case 'AOA':
        return 'Angola Kwanzası ';
      case 'KHR':
        return 'Kamboçya Rieli';
      case 'MYR':
        return 'Malezya Ringgiti';
      case 'LYD':
        return 'Libya Dinarı';
      case 'UAH':
        return 'Ukrayna Grivnası ';
      case 'JOD':
        return 'Ürdün Dinarı';
      case 'AWG':
        return 'Aruba Florini ';
      case 'SAR':
        return 'Suudi Arabistan Riyali';
      case 'XAG':
        return 'Gümüş';
      case 'HKD':
        return 'Hong Kong Doları';
      case 'CHF':
        return 'İsviçre Frangı';
      case 'GIP':
        return 'Cebelitarık Poundu';
      case 'MRU':
        return 'Moritanya Ugiyası ';
      case 'ALL':
        return 'Arnavutluk Leki ';
      case 'XPD':
        return 'Paladyum Spot Amerikan Doları';
      case 'BYN':
        return 'Beyaz Rusya Rublesi';
      case 'HRK':
        return 'Hırvat kunası';
      case 'DJF':
        return 'Cibuti Frangı ';
      case 'SZL':
        return 'Svaziland Lilangenisi ';
      case 'THB':
        return 'Tayland Bahtı';
      case 'XAF':
        return 'Orta Afrika CFA Frangı';
      case 'BND':
        return 'Brunei Doları ';
      case 'ISK':
        return 'İzlanda Kronu';
      case 'UYU':
        return 'Uruguay Pesosu';
      case 'NIO':
        return 'Nikaragua Kordobası';
      case 'LAK':
        return 'Laos Kipi';
      case 'SYP':
        return 'Suriye Lirası';
      case 'MAD':
        return 'Fas Dirhemi';
      case 'MZN':
        return 'Mozambik Meticalı';
      case 'PHP':
        return 'Filipin Pesosu ';
      case 'ZAR':
        return 'Güney Afrika Randı ';
      case 'NPR':
        return 'Nepal Rupisi ';
      case 'ZWL':
        return 'Zimbabve Doları';
      case 'NGN':
        return 'Nijerya Nairası';
      case 'CRC':
        return 'Kosta Rika Kolonu';
      case 'AED':
        return 'Birleşik Arap Emirlikleri Dirhemi';
      case 'MWK':
        return 'Malavi Kvaçası';
      case 'LKR':
        return 'Sri Lanka Rupisi ';
      case 'PKR':
        return 'Pakistan Rupisi';
      case 'HUF':
        return 'Macar Forinti';
      case 'BMD':
        return 'Bermuda Doları';
      case 'LSL':
        return 'Lesoto Lotisi ';
      case 'MNT':
        return 'Moğolistan Tugriki';
      case 'AMD':
        return 'Ermenistan Dramı';
      case 'UGX':
        return 'Uganda Şilini';
      case 'QAR':
        return 'Katar Riyali';
      case 'STN':
        return 'São Tomé ve Príncipe Dobrası';
      case 'JMD':
        return 'Jamaika Doları ';
      case 'GEL':
        return 'Gürcü Larisi';
      case 'SHP':
        return 'Saint Helena Sterlini';
      case 'AFN':
        return 'Afgan Afganisi';
      case 'SBD':
        return 'Solomon Adaları Doları';
      case 'KPW':
        return 'Kuzey Kore Wonu';
      case 'TRY':
        return 'Türk Lirası';
      case 'BDT':
        return 'Bangladeş Takası';
      case 'YER':
        return 'Yemen Riyali';
      case 'HTG':
        return 'Haiti Gourdesi';
      case 'XOF':
        return 'Batı Afrika CFA Frangı';
      case 'MGA':
        return 'Madagaskar Ariarisi';
      case 'ANG':
        return 'Hollanda Antilleri Guldeni';
      case 'LRD':
        return 'Liberya Doları';
      case 'RWF':
        return 'Ruanda Frangı';
      case 'MOP':
        return 'Makao Patakası';
      case 'SSP':
        return 'Güney Sudan Poundu';
      case 'INR':
        return 'Hindistan Rupisi';
      case 'MXN':
        return 'Meksika Pesosu';
      case 'CZK':
        return 'Çek Korunası';
      case 'TJS':
        return 'Tacikistan Somonisi';
      case 'BTN':
        return 'Bhutan Ngultrumu';
      case 'COP':
        return 'Kolombiya Pesosu';
      case 'TMT':
        return 'Türkmenistan Manatı';
      case 'MUR':
        return 'Mauritius Rupisi';
      case 'IDR':
        return 'Endonezya Rupisi';
      case 'HNL':
        return 'Honduras Lempirası';
      case 'XPF':
        return 'CFP Frangı';
      case 'FJD':
        return 'Fiji Doları';
      case 'ETB':
        return 'Etiyopya Birri';
      case 'PEN':
        return 'Peru Solü';
      case 'BZD':
        return 'Belize Doları';
      case 'ILS':
        return 'Yeni İsrail Şekeli';
      case 'DOP':
        return 'Dominik Pesosu';
      case 'GGP':
        return 'Guernsey Poundu';
      case 'MDL':
        return 'Moldova Leyi';
      case 'XPT':
        return 'Platin Spot Amerikan Doları';
      case 'BSD':
        return 'Bahama Doları';
      case 'SEK':
        return 'İsveç Kronu';
      case 'JEP':
        return 'Jersey Poundu';
      case 'AUD':
        return 'Avustralya Doları';
      case 'SRD':
        return 'Surinam Doları';
      case 'CUP':
        return 'Küba Pesosu';
      case 'CLF':
        return 'Unidad de Fomento';
      case 'BBD':
        return 'Barbados Doları';
      case 'KMF':
        return 'Komor Frangı';
      case 'KRW':
        return 'Güney Kore Wonu';
      case 'GMD':
        return 'Gambiya Dalasisi';
      case 'IMP':
        return 'Man Adası Poundu';
      case 'CUC':
        return 'Çevrilebilir Küba Pesosu';
      case 'CLP':
        return 'Şili Pesosu';
      case 'ZMW':
        return 'Zambiya Kvaçası';
      case 'CDF':
        return 'Kongo Frangı';
      case 'VES':
        return 'Venezuela Bolivarı';
      case 'KZT':
        return 'Kazakistan Tengesi';
      case 'RUB':
        return 'Rus Rublesi';
      case 'TTD':
        return 'Trinidad ve Tobago Doları';
      case 'OMR':
        return 'Umman Riyali';
      case 'BRL':
        return 'Brezilya Reali';
      case 'MMK':
        return 'Myanmar Kyatı';
      case 'PLN':
        return 'Polonya Zlotisi';
      case 'PYG':
        return 'Paraguay Guaranísi';
      case 'KES':
        return 'Kenya Şilini';
      case 'SVC':
        return 'El Salvador Kolonu';
      case 'MKD':
        return 'Makedonya Dinarı';
      case 'AZN':
        return 'Azerbaycan Manatı';
      case 'TOP':
        return 'Tonga Paangası ';
      case 'MVR':
        return 'Maldiv Rufiyası';
      case 'VUV':
        return 'Vanuatu Vatusu';
      case 'GNF':
        return 'Gine Frangı';
      case 'WST':
        return 'Samoa Talası';
      case 'IQD':
        return 'Irak Dinarı';
      case 'ERN':
        return 'Eritre Nakfası';
      case 'BAM':
        return 'Bosna-Hersek Markı';
      case 'SCR':
        return 'Seyşeller Rupisi';
      case 'CAD':
        return 'Kanada Doları';
      case 'CVE':
        return 'Yeşil Burun Adaları Eskudosu';
      case 'KWD':
        return 'Kuveyt Dinarı';
      case 'BIF':
        return 'Burundi Frangı';
      case 'PGK':
        return 'Papua Yeni Gine Kinası';
      case 'SOS':
        return 'Somali Şilini';
      case 'TWD':
        return 'Yeni Tayvan Doları';
      case 'SGD':
        return 'Singapur Doları';
      case 'UZS':
        return 'Özbekistan Somu';
      case 'STD':
        return 'São Tomé ve Príncipe Dobrası';
      case 'IRR':
        return 'İran Riyali';
      case 'CNY':
        return 'Çin Yuanı';
      case 'SLL':
        return 'Sierra Leone Leonesi';
      case 'TND':
        return 'Tunus Dinarı';
      case 'GYD':
        return 'Guyana Doları';
      case 'NZD':
        return 'Yeni Zelanda Doları';
      case 'FKP':
        return 'Falkland Adaları Poundu';
      case 'CNH':
        return 'Çin Para Birimi (YUAN)';
      case 'KGS':
        return 'Kırgızistan Somu';
      case 'ARS':
        return 'Arjantin Pesosu';
      case 'RON':
        return 'Rumen Leyi';
      case 'GTQ':
        return 'Guatemala Quetzalı';
      case 'RSD':
        return 'Sırp Dinarı';
      case 'BHD':
        return 'Bahreyn Dinarı';
      case 'JPY':
        return 'Japon Yeni';
      case 'SDG':
        return 'Sudan Sterlini';
      case 'XAU':
        return 'Altın';

      default:
        return currency;
    }
  }
}
