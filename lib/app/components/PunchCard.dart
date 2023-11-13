import 'package:flutter/material.dart';

class PunchCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color bgColor;
  final void Function() onTap;

 const PunchCard({
    super.key,
    required  this.icon,
    required this.text,
    required this.bgColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child:  GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14.0),
          height: 85.0,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            // image: const DecorationImage(
            //   image: AssetImage("assets/img/bg_img.png"),
            //   fit: BoxFit.cover,
            // ),
          ),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 50.0,
              ),
             const Spacer(flex: 1,),
              Text(text, style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.white),),
            ],
          ),
        ),
      ),
    );
  }
}
