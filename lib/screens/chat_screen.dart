import 'package:chat_app/helper/const%20&%20functions.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatefulWidget {
  static String id = 'ChatScreen';



  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ScrollController scrollController = ScrollController();

  void scrollToBottom() {
    scrollController.animateTo(
      0,
      duration: const Duration(seconds: 2),
      curve: Curves.easeInOut,
    );
  }

  // give me a reference for this collection => message
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);

  TextEditingController controller = TextEditingController();

  // what is the difference between ( FutureBuilder && StreamBuilder)??
  // THE FutureBuilder build the UI depend on the data will receive in the future
  // but StreamBuilder build UI many times depend on the data come from future
  // بالبلدي يعني الستريم اي تغير فيه بيفضل مسمع وبيغير ال ui تلقائي
  @override
  Widget build(BuildContext context) {

    var email= ModalRoute.of(context)!.settings.arguments;
    // access data from fire store
    return StreamBuilder<QuerySnapshot>(
      //i used snapshot instead of .get cuz i want stream thing update data always
      stream: messages.orderBy(kCreatedAt,descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          // now i will use for loop to focus on each document
          //and store it in a message model
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(Message.fromJson(
              snapshot.data!.docs[i],
            ));
          }
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: kPrimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/chatIcon.png',
                    width: 25,
                    height: 30,
                  ),
                  const Text(
                    ' Chat ',
                    style: TextStyle(fontSize: 25),
                  )
                ],
              ),
            ),
            body: Column(
              children: [
                // messages in list view
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: scrollController,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id ==email? ChatBubble(
                        message: messagesList[index],
                        alignment: Alignment.centerRight,
                        fontColor: Colors.white,
                        color: kPrimaryColor,

                      ): ChatBubble(
                        message: messagesList[index],
                        alignment: Alignment.centerLeft,
                        fontColor: Colors.black,
                        border: Border.all(color: kPrimaryColor, width: 2),
                      );
                    },
                  ),
                ),
                // textField responsible for sending message
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    onTap: () {
                      String message = controller.text.trim();
                      if (message.isNotEmpty) {
                        messages.add({
                          kMessage: message,
                          kCreatedAt: DateTime.now(),
                          'id': email
                        });
                        // to clear message from textField after sending it to fireStore cloud
                        controller.clear();

                        scrollToBottom();
                      }
                      // Dismiss the keyboard when tapping outside the text field or click on send icon

                      FocusScope.of(context).unfocus();
                    },
                    controller: controller,
                    onSubmitted: (data) {
                      messages
                          .add({
                        kMessage: data,
                        kCreatedAt: DateTime.now(),
                        'id': email
                      });
                      // to clear message from textField after sending it to fireStore cloud
                      controller.clear();
                      scrollToBottom();
                    },
                    decoration: const InputDecoration(
                      hintText: 'Send message',
                      suffixIcon: Icon(
                        Icons.send_sharp,
                        color: kPrimaryColor,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: kPrimaryColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: kPrimaryColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Scaffold(
              body: Center(
                  child: Text(
            'Loading ...',
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          )));
        }
      },
    );
  }
}
