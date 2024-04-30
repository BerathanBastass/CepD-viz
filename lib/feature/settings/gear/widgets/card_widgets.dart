import 'package:cepdovizapp/core%20/utils/custom_colors.dart';
import 'package:flutter/material.dart';


class BuildCard extends StatelessWidget {
  final int index;
  final String language;
  final IconData iconData;
  final bool isSelected;
  final VoidCallback onTap;

  const BuildCard({
    Key? key,
    required this.index,
    required this.language,
    required this.iconData,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = isSelected ? Colors.white : Colors.white;
    Color textColor = isSelected ? Colors.black : Colors.black;
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(15),
      color: backgroundColor,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                language,
                style: TextStyle(color: textColor),
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
