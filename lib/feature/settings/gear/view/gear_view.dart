import 'package:cepdovizapp/core%20/enums/applocalizations.dart';
import 'package:cepdovizapp/core%20/enums/enums.dart';
import 'package:cepdovizapp/core%20/shared_preferences/constans/shared_preferences.dart';
import 'package:cepdovizapp/core%20/utils/custom_colors.dart';
import 'package:cepdovizapp/feature/settings/gear/widgets/card_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cepdovizapp/feature/settings/gear/cubit/gear_cubit.dart';
import 'package:cepdovizapp/feature/settings/gear/cubit/gear_state.dart';

class Gear extends StatelessWidget {
  const Gear({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, LocalizationState>(
      builder: (context, state) {
        int selectedCardIndex =
        SharedPreferencesHelper.getData('lang') == 'tr' ? 0 : 1;
        return Scaffold(
          appBar: AppBar(
            scrolledUnderElevation: 0,
            backgroundColor: CustomColors.salt,
            title: Text(
              AppLocalizations.of(context).translate('Ayarlar'),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: CustomColors.salt,
          body: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 25, 10, 0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 1, 1, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppLocalizations.of(context).translate('Dil'),
                          style: const TextStyle(fontSize: 30),
                        ),
                      ),
                    ),
                    const SizedBox(height: 1),
                    BuildCard(
                      index: 1,
                      language: AppLocalizations.of(context).translate("Türkçe"),
                      iconData: FontAwesomeIcons.globe,
                      isSelected: selectedCardIndex == 1,
                      onTap: () {
                        context
                            .read<LocalizationCubit>()
                            .changeLanguage(LanguagesTypesEnums.turkey);
                      },
                    ),
                    const SizedBox(height: 1),
                    BuildCard(
                      index: 0,
                      language: AppLocalizations.of(context).translate("İngilizce"),
                      iconData: FontAwesomeIcons.globe,
                      isSelected: selectedCardIndex == 0,
                      onTap: () {
                        context
                            .read<LocalizationCubit>()
                            .changeLanguage(LanguagesTypesEnums.english);
                      },
                    ),
                    Transform.translate(
                      offset: const Offset(0, 50),
                      child: Image.asset(
                        "assets/girl.png",
                      ),
                    ),
                    const SizedBox(height: 70),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
