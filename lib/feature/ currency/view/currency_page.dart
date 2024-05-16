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
  // ignore: library_private_types_in_public_api
  _CurrencyListPageViewState createState() => _CurrencyListPageViewState();
}

class _CurrencyListPageViewState extends State<CurrencyListPageView> {
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

  Widget buildCurrencyList(BuildContext context, CurrencyListLoadedState state,
      CurrencyListCubit cubit) {
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
        Transform.translate(
          offset: const Offset(-130, 18),
          child: Text(
            AppLocalizations.of(context).translate('ParaBirimleri'),
            style: const TextStyle(
              color: CustomColors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ),
        Transform.translate(
          offset: const Offset(-10, 5),
          child: Text(
            AppLocalizations.of(context).translate('GDeğişim'),
            style: const TextStyle(
              color: CustomColors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ),
        Transform.translate(
          offset: const Offset(100, -10),
          child: Text(
            AppLocalizations.of(context).translate('Fiyat'),
            style: const TextStyle(
              color: CustomColors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 10,
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
                final formattedRate = rate.toStringAsFixed(2);

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
                    title: Transform.translate(
                      offset: const Offset(0, 20),
                      child: Text(
                        cubit.getFullCurrencyName(currency),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (isIncreasing)
                          Text(
                            '+$decreaseAmount%',
                            style: const TextStyle(color: CustomColors.green),
                          )
                        else
                          Text(
                            '-$decreaseAmount%',
                            style: const TextStyle(color: CustomColors.red),
                          ),
                        Transform.translate(
                          offset: const Offset(100, -20),
                          child: Text(
                            '\$$formattedRate',
                            style: TextStyle(
                              color: isIncreasing
                                  ? CustomColors.green
                                  : CustomColors.red,
                            ),
                          ),
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
