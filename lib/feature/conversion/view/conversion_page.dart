import 'package:cepdovizapp/core%20/enums/applocalizations.dart';
import 'package:cepdovizapp/core%20/utils/custom_colors.dart';
import 'package:cepdovizapp/feature/conversion/cubit/currency_cubit.dart';
import 'package:cepdovizapp/feature/conversion/cubit/currency_state.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_loading_button/easy_loading_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class CurrencyConverterPage extends StatefulWidget {
  const CurrencyConverterPage({super.key});

  @override
  State<CurrencyConverterPage> createState() => _CurrencyConverterPageState();
}

class _CurrencyConverterPageState extends State<CurrencyConverterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.salt,
      appBar: AppBar(
        backgroundColor: CustomColors.salt,
        title: Text(
          AppLocalizations.of(context).translate('DövizÇevirici'),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocProvider(
        create: (context) => CurrencyConverterCubit(),
        child: const CurrencyConverterView(),
      ),
    );
  }
}

class CurrencyConverterView extends StatefulWidget {
  const CurrencyConverterView({super.key});

  @override
  State<CurrencyConverterView> createState() => _CurrencyConverterViewState();
}

class _CurrencyConverterViewState extends State<CurrencyConverterView> {
  final TextEditingController _amountController = TextEditingController();
  late Map<String, String> _currencyNames;
  String? _selectedCurrency;

  @override
  Widget build(BuildContext context) {
    _currencyNames = {
      'TRY': AppLocalizations.of(context).translate('Try'),
      'EUR': 'Euro',
      'USD': AppLocalizations.of(context).translate('Dolar'),
      'GBP': AppLocalizations.of(context).translate('İngilizSterlini'),
      'JPY': AppLocalizations.of(context).translate('JaponYeni'),
      'RUB': AppLocalizations.of(context).translate('RusRublesi'),
      'KWD': AppLocalizations.of(context).translate('KuveytDinarı'),
      'BHD': AppLocalizations.of(context).translate('BahreynDinarı'),
      'CNY': 'Renminbi',
      'AUD': AppLocalizations.of(context).translate('AvustralyaDoları'),
      'CAD': AppLocalizations.of(context).translate('KanadaDoları'),
      'CHF': AppLocalizations.of(context).translate('İsviçreFrangı'),
    };

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: DropdownButton2<String>(
              value: _selectedCurrency,
              items: _currencyNames.keys.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    _currencyNames[value]!,
                  ),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _selectedCurrency = value;
                });
              },
              hint: const Icon(FontAwesomeIcons.dollarSign),
              dropdownStyleData: const DropdownStyleData(
                decoration: BoxDecoration(
                  color: CustomColors.salt,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).translate('Miktar'),
              labelStyle: const TextStyle(color: Colors.black),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EasyButton(
                onPressed: () {
                  final double amount = double.tryParse(_amountController.text) ?? 0.0;
                  final String selectedCurrency = _selectedCurrency ?? 'TRY';
                  if (amount > 0) {
                    BlocProvider.of<CurrencyConverterCubit>(context).convertCurrency(amount, selectedCurrency);
                  } else {
                  }
                },
                idleStateWidget:  Text(
                  style: const TextStyle(color: Colors.white),
                  AppLocalizations.of(context).translate('Dönüştür'),
                ),
                loadingStateWidget: const CircularProgressIndicator(
                  strokeWidth: 5.0,
                  valueColor: AlwaysStoppedAnimation<Color>(CustomColors.grey),
                ),
                useWidthAnimation: true,
                useEqualLoadingStateWidgetDimension: true,
                width: 150.0,
                height: 70.0,
                buttonColor: Colors.black,
              ),
            ],
          ),
          const SizedBox(height: 20),
          BlocBuilder<CurrencyConverterCubit, CurrencyConverterState>(
            builder: (context, state) {
              if (state is CurrencyConverterLoaded) {
                return Column(
                  children: [
                    Center(
                      child: Text(
                        '${state.usdAmount.toStringAsFixed(2)} USD',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        '${state.convertedAmount.toStringAsFixed(2)} TRY',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                );
              } else if (state is CurrencyConverterLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 5.0,
                    valueColor: AlwaysStoppedAnimation<Color>(CustomColors.grey),
                  ),
                );
              } else if (state is CurrencyConverterError) {
                return Center(
                  child: Text(
                    AppLocalizations.of(context).translate('Hata oluştu!'),
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
