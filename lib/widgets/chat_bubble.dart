import 'package:chat_app/models/message.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatBubble extends StatelessWidget {


  Border? border;
  Color? color;
  Color fontColor;
  Alignment alignment;
  Message message;

  ChatBubble({
    this.color,
    required this.fontColor,
    required this.alignment,
    this.border,
    required this.message,
  });



  @override
  Widget build(BuildContext context) {

    // String formattedTime = DateFormat.Hm().format(message.timestamp);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: alignment,
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: border,
              borderRadius: BorderRadius.circular(10),
              color: color,
            ),
            child: Text(
              message.message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: fontColor,
              ),
            ),
          ),
        ),
        // Align(
        //   alignment: alignment,
        //   child: Container(
        //     padding: EdgeInsets.all(8),
        //     margin: EdgeInsets.only(left: 10, right: 10),
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(10),
        //       color: Color(0xffD7D1D1),
        //     ),
        //     child: Text(
        //       formattedTime,
        //       style: TextStyle(color: Color(0xff7D7B7B)),
        //     ),
        //   ),
        // )
      ],
    );
  }
}