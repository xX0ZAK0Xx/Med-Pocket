import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:med_pocket/common/styles/styles.dart';

class MedicineCard extends StatelessWidget {
  const MedicineCard({
    Key? key,
    required this.type,
    required this.name,
    required this.time,
  }) : super(key: key);

  final String type, name, time;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        gradient: pinkGradient(),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.red.shade200,
            offset: const Offset(0, 0),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              gradient: redGradient(),
            ),
            child: Icon(
              type.toLowerCase() == 'tablet'
                  ? FontAwesomeIcons.pills
                  : type.toLowerCase() == 'injection'
                      ? FontAwesomeIcons.syringe
                      : FontAwesomeIcons.bottleDroplet,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                name,
                style: headline(),
                overflow: TextOverflow.ellipsis, // Add this to handle long names
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              gradient: pinkGradient(),
            ),
            child: Center(
              child: Text(
                time,
                style: headline(s: 18.0),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
