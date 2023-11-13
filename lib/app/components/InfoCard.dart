import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String heading;
  final String text1;
  final String text2;
  final Color bgColor;
  late Function() onTap;

  InfoCard({
    super.key,
    required  this.icon,
    required this.heading,
    required this.text1,
    required this.text2,
    required this.bgColor,
     required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child:  GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(20.0),
          height: 173.0,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            // image: const DecorationImage(
            //   image: AssetImage("assets/img/bg_img.png"),
            //   fit: BoxFit.contain,
            //   alignment: Alignment(2.0, 0.0),
            // ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50.0,
                width: 50.0,
                decoration:const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5.0))
                ),
                child: Icon(
                  icon,
                  color: bgColor,
                  size: 28.0,
                ),
              ),
             const Spacer(flex: 1,),
              Text(heading, style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.white),),
              const SizedBox(height: 4.0),
              Text(text1, style: const TextStyle(fontSize: 11.0, fontWeight: FontWeight.w400, color: Colors.white),),
              const SizedBox(height: 4.0),
              Text(text2, style: const TextStyle(fontSize: 11.0, fontWeight: FontWeight.w400, color: Colors.white),),
            ],
          ),
        ),
      ),
    );
  }
}
