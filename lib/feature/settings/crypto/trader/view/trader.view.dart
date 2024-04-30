import 'package:cepdovizapp/core%20/utils/custom_colors.dart';
import 'package:cepdovizapp/feature/settings/crypto/trader/cubit/tradewidget_cubit.dart';
import 'package:cepdovizapp/feature/settings/crypto/trader/cubit/tradewidget_state.dart';
import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class TradeWidget extends StatelessWidget {
  final Map<String, dynamic> crypto;

  const TradeWidget({super.key, required this.crypto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.salt,
      appBar: AppBar(
        scrolledUnderElevation: 00,
        backgroundColor: CustomColors.salt,
        title: Text(
          crypto['name'],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocProvider(
        create: (context) => TradeCubit()..fetchTradeData(crypto['id']),
        child: const TradeView(),
      ),
    );
  }
}

class TradeView extends StatelessWidget {
  const TradeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TradeCubit, TradeState>(
      builder: (context, state) {
        if (state is TradeInitial) {
          return const Center(
            child: CircularProgressIndicator(
              color: CustomColors.grey,
              strokeWidth: 5,
            ),
          );
        } else if (state is TradeLoaded) {
          final Map<String, dynamic> tradeData = state.tradeData;

          double lastPriceUsd = double.parse(tradeData['priceUsd']);
          double changePercent24HrNum = double.parse(tradeData['changePercent24Hr']);

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    "\$${lastPriceUsd.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Sparkline(
                      data: List.generate(24, (index) {
                        double price = lastPriceUsd + (index * 2 * (changePercent24HrNum < 0 ? -1 : 1));
                        return price;
                      }),
                      lineColor: changePercent24HrNum < 0 ? CustomColors.red : CustomColors.green,
                      fillMode: FillMode.below,
                      fillGradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.lightBlueAccent,
                        ],
                      ),
                      lineWidth: 2.0,
                      pointsMode: PointsMode.all,
                      pointSize: 4.0,
                      pointColor: Colors.black,
                      sharpCorners: true,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      changePercent24HrNum < 0
                          ? Icons.arrow_drop_down
                          : Icons.arrow_drop_up,
                      size: 20,
                      color: changePercent24HrNum < 0
                          ? CustomColors.red
                          : CustomColors.green,
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
              ),
            ],
          );
        } else if (state is TradeError) {
          return Center(
            child: Text('Error loading trade data: ${state.errorMessage}'),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
