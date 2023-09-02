import 'package:flutter/material.dart';


const kPrimaryColor =  Color(0XFF771F98);
const kMessagesCollections = 'messages';
const kMessage = 'message';
const kCreatedAt = 'createdAt';
const String kTimestamp = 'timestamp';


void showSnackBar(context,{required String message}){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(message)
      )
  );
}
