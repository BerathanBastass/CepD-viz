import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Widget buildCard(
    String title,
    IconData iconData,
    VoidCallback? onTapFunction,
    ) {
  return Card(
    elevation: 1,
    margin: const EdgeInsets.all(8),
    child: InkWell(
      onTap: onTapFunction,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 50,
              color: Colors.black,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void launchInstagram() async {
  const url = 'https://www.instagram.com/cepdoviz';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Instagram sayfası açılamadı: $url';
  }
}
