// i have list of messages so i should make a model
// for every message
import 'package:chat_app/helper/const%20&%20functions.dart';

class Message{

 final String message;
 final String id;


  Message(this.message, this.id);
//the data is json data , should decode it to receive it in string
  factory Message.fromJson(jsonData){
    // return a message from map i will send and receive
    return Message(
        jsonData[kMessage],
        jsonData['id']
    );
  }
}