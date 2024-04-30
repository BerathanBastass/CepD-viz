import 'package:asuka/asuka.dart';
import 'package:cepdovizapp/core%20/enums/applocalizations.dart';
import 'package:cepdovizapp/feature/settings/news/view/news_view.dart';
import 'package:flutter/material.dart';
import 'package:cepdovizapp/core%20/utils/custom_colors.dart';
import 'package:cepdovizapp/feature/settings/crypto/view/crypto_view.dart';
import 'package:cepdovizapp/feature/settings/gear/view/gear_view.dart';
import 'package:cryptofont/cryptofont.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'widgets/card_widgetss.dart';


class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 00,
        actions: [
          IconButton(
            onPressed: () {
              launchInstagram();
            },
            icon: const Icon(
              FontAwesomeIcons.instagram,
              size: 30,
            ),
          )
        ],
        title: Text(
          AppLocalizations.of(context).translate("İçerik"),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: CustomColors.salt,
      ),
      backgroundColor: CustomColors.salt,
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: [
                Transform.translate(
                  offset: const Offset(100, 10),
                  child: Image.asset(
                    "assets/human_money.png",
                    fit: BoxFit.fitWidth,
                  ),
                ),
                const SizedBox(height: 10),
                buildCard(
                  AppLocalizations.of(context).translate("Kripto"),
                  CryptoFontIcons.btc,
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyHomePage(
                          title: '',
                        ),
                      ),
                    );
                  },
                ),
                buildCard(
                  AppLocalizations.of(context).translate("Haber"),
                  FontAwesomeIcons.newspaper,
                      () {
                    AsukaSnackbar.warning(
                      AppLocalizations.of(context)
                          .translate("HaberlerBildirim"),
                    ).show();

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const NewsPage()),
                    );
                  },
                ),
                Transform.translate(
                  offset: const Offset(90, 10),
                  child: buildCard(
                    AppLocalizations.of(context).translate("Ayarlar"),
                    FontAwesomeIcons.gear,
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Gear()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
