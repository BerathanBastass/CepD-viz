import 'package:cepdovizapp/feature/settings/crypto/trader/cubit/tradewidget_cubit.dart';
import 'package:cepdovizapp/feature/settings/crypto/view/cubit/cryptocubit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../feature/ currency/cubit/currency_cubit.dart';
import '../../feature/conversion/cubit/currency_cubit.dart';
import '../../feature/settings/gear/cubit/gear_cubit.dart';

class AppBlocProvider extends StatelessWidget {
  final Widget child;

  const AppBlocProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CurrencyListCubit>(
          create: (context) => CurrencyListCubit(),
        ),
        BlocProvider<LocalizationCubit>(
          create: (context) => LocalizationCubit(),
        ),
        BlocProvider<CurrencyConverterCubit>(
          create: (context) => CurrencyConverterCubit(),
        ),
        BlocProvider<CryptoCubit>(
          create: (context) => CryptoCubit(),
        ),
        BlocProvider<TradeCubit>(
          create: (context) => TradeCubit(),
        ),
      ],
      child: child,
    );
  }
}
