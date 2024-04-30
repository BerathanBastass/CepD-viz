import 'package:cepdovizapp/core%20/enums/applocalizations.dart';
import 'package:cepdovizapp/feature/settings/crypto/view/cubit/cryptocubit_cubit.dart';
import 'package:cepdovizapp/feature/settings/crypto/view/cubit/cryptocubit_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core /utils/custom_colors.dart';
import '../trader/view/trader.view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    context.read<CryptoCubit>().updateCryptoData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.salt,
      appBar: AppBar(
        scrolledUnderElevation: 00,
        backgroundColor: CustomColors.salt,
        title:  Text(
          AppLocalizations.of(context).translate('Piyasa'),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<CryptoCubit, CryptoState>(
        builder: (context, state) {
          if (state is CryptoLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: CustomColors.grey,
                strokeWidth: 5,
              ),
            );
          } else if (state is CryptoLoaded) {
            return _buildCryptoListView(state);
          } else if (state is CryptoError) {
            return Center(child: Text(state.errorMessage));
          } else {
            return const Center(child: Text('Hata Mesajı'));
          }
        },
      ),
    );
  }

  Widget _buildCryptoListView(CryptoLoaded state) {
    return ListView.builder(
      itemCount: state.cryptoList.length,
      itemBuilder: (BuildContext context, int index) {
        final changePercent24Hr = state.cryptoList[index]['changePercent24Hr'];
        final changePercent24HrNum = double.tryParse(changePercent24Hr) ?? 0.0;
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TradeWidget(
                  crypto: state.cryptoList[index],
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${state.cryptoList[index]['name']}",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "${state.cryptoList[index]['symbol']}/USD",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "\$${double.parse(state.cryptoList[index]['priceUsd']).toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Row(
                            children: [
                              Image.asset(
                                changePercent24HrNum < 0
                                    ? "assets/red_line.png"
                                    : "assets/green_line.png",
                                width: 15,
                                height: 20,
                              ),
                              Text(
                                "${changePercent24HrNum.toStringAsFixed(2)}%",
                                style: TextStyle(
                                  color: changePercent24HrNum < 0
                                      ? CustomColors.red
                                      : CustomColors.green,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
