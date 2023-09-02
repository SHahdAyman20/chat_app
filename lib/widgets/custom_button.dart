import 'package:chat_app/helper/const & functions.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
   CustomButton({
     required this.text,
     required this.onTap
   });

  VoidCallback onTap;
  String text;

   @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(
          onPressed:onTap,
          child: Text(
            text,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800
            ),
          ),
          style: ElevatedButton.styleFrom(
              primary: kPrimaryColor,
              minimumSize: Size(
                  MediaQuery.of(context).size.width*0.79
                  ,
                  45),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)
              )
          )
      ),
    );
  }
}
