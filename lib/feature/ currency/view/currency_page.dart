import 'package:cepdovizapp/core%20/enums/applocalizations.dart';
import 'package:cepdovizapp/core%20/utils/custom_colors.dart';
import 'package:cepdovizapp/feature/%20currency/cubit/currency_cubit.dart';
import 'package:cepdovizapp/feature/%20currency/cubit/currency_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CurrencyListPage extends StatelessWidget {
  const CurrencyListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CurrencyListCubit(),
      child: const CurrencyListPageView(),
    );
  }
}

class CurrencyListPageView extends StatefulWidget {
  const CurrencyListPageView({super.key});

  @override
  CurrencyListPageViewState createState() => CurrencyListPageViewState();
}

class CurrencyListPageViewState extends State<CurrencyListPageView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CurrencyListCubit>(context);
    cubit.init(AppLocalizations.of(context));

    return Scaffold(
      backgroundColor: CustomColors.salt,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: CustomColors.salt,
        title: Text(
          AppLocalizations.of(context).translate('DövizKurları'),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<CurrencyListCubit, CurrencyListState>(
        builder: (context, state) {
          if (state is CurrencyListLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.grey,
                strokeWidth: 7,
              ),
            );
          } else if (state is CurrencyListErrorState) {
            return const Center();
          } else if (state is CurrencyListLoadedState) {
            return buildCurrencyList(context, state, cubit);
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget buildCurrencyList(BuildContext context, CurrencyListLoadedState state, CurrencyListCubit cubit) {
    final exchangeRates = state.exchangeRates;
    final filteredCurrencies = state.filteredCurrencies;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            onChanged: (searchText) {
              cubit.filterCurrencies(searchText, exchangeRates);
            },
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context).translate('AramaYapın'),
              hintStyle: const TextStyle(color: Colors.black),
              prefixIcon: const Icon(Icons.search),
              border: const OutlineInputBorder(),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: CustomColors.salt),
              ),
              focusColor: Colors.black,
            ),
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            backgroundColor: CustomColors.salt,
            color: CustomColors.grey,
            onRefresh: cubit.refreshList,
            child: ListView.builder(
              itemCount: filteredCurrencies.length,
              itemBuilder: (context, index) {
                final currency = filteredCurrencies[index];
                final rate = exchangeRates[currency]!;
                final tlRate = 1 / rate;
                final formattedRate = rate.toStringAsFixed(2);
                final formattedTlRate = tlRate.toStringAsFixed(2);

                double previousRate = 0.0;
                if (index > 0) {
                  previousRate = exchangeRates[filteredCurrencies[index - 1]]!;
                }
                final isIncreasing = previousRate < rate;
                final decreaseAmount = (previousRate - rate).toStringAsFixed(1);

                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.all(15),
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cubit.getFullCurrencyName(currency),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$formattedRate / 1 USD',
                          style: TextStyle(
                            color: isIncreasing ? CustomColors.green : CustomColors.red,
                          ),
                        ),
                        Text(
                          '$formattedTlRate / 1 TRY',
                          style: TextStyle(
                            color: isIncreasing ? CustomColors.green : CustomColors.red,
                          ),
                        ),
                        if (!isIncreasing)
                          Text(
                            '-$decreaseAmount%',
                            style: const TextStyle(color: CustomColors.red),
                          ),
                      ],
                    ),

                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

