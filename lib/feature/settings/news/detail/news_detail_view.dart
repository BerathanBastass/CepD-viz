import 'package:cepdovizapp/core%20/enums/applocalizations.dart';
import 'package:cepdovizapp/core%20/utils/custom_colors.dart';
import 'package:flutter/material.dart';


class NewsDetailPage extends StatelessWidget {
  final String? title;
  final String? description;
  final String? date;
  final String? imageUrl;

  const NewsDetailPage({
    super.key,
    this.title,
    this.description,
    this.date,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.salt,
      appBar: AppBar(
        scrolledUnderElevation: 00,
        backgroundColor: CustomColors.salt,
        title: Text(
          AppLocalizations.of(context).translate('HaberDetay'),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 1)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: CustomColors.grey,
                strokeWidth: 5,
              ),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  imageUrl ?? '',
                  height: MediaQuery.of(context).size.height / 3.70,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 20.0),
                Text(
                  title ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  date ?? '',
                  style: const TextStyle(
                    color: CustomColors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                ),
                const SizedBox(height: 20.0),
                Text(
                  description ?? '',
                  style: const TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
