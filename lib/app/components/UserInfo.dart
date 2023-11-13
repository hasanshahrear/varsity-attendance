import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  final String name;
  final String designation;
  final String distance;
  final String imgUrl;

  const UserInfo(
      {super.key,
      required this.name,
      required this.designation,
      required this.distance,
      required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
      margin: const EdgeInsets.symmetric(vertical: 15.0),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            (name),
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22.0,
              letterSpacing: 0.5,
              color: Colors.white,
            ),
          ),
          Text(
            (designation),
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              color: Color.fromRGBO(238, 237, 237, 1),
              fontSize: 14.0,
            ),
          ),
          Text(
            distance,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14.0,
              color: Colors.white,
              decoration: TextDecoration.underline,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
