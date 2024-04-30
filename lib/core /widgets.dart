import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'utils/custom_colors.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton(
      {super.key, required this.text, required this.onPresed});
  final String text;
  final AsyncCallback onPresed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.cyan.shade900,
        ),
        onPressed: onPresed,
        child: Text(text));
  }
}

class NotificationServices {
  static Future<void> showSnackbar(BuildContext context, String message) async {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget buildCard(int index, String language, IconData iconData,
      bool isSelected, VoidCallback onTap) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(15),
      color: isSelected ? CustomColors.saltWhite : Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                language,
                style: const TextStyle(color: Colors.black),
              ),
              Icon(
                iconData,
                size: 30,
                color: CustomColors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
