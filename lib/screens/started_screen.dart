
import 'package:chat_app/helper/const & functions.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/login_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class StartedScreen extends StatelessWidget {
  const StartedScreen({Key? key}) : super(key: key);

  static String id='StartedPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
         const Padding(
            padding:  EdgeInsets.only(top: 80,bottom: 10),
            child: Text(
                'Get Closer To \nEveryOne',
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
         const Text(
            'Helps you to contact everyone with\njust easy way',
            style: TextStyle(
                fontSize: 20,
            ),
          ),
         const Padding(
            padding:  EdgeInsets.only(right: 20,top: 10),
            child: Image(image: AssetImage('assets/Dayflow Best Friends.png')),
          ),
          Padding(
           padding: const EdgeInsets.only(
             top: 40
           ),
           child: ElevatedButton(
               onPressed: (){
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) =>  LoginPage()),
                 );
               },
               style: ElevatedButton.styleFrom(
                   backgroundColor: kPrimaryColor,
                   minimumSize: Size(
                       MediaQuery.of(context).size.width*0.79
                       ,
                       45
                   ),
                   shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(20.0)
                   )
               ),
               child:const Text(
                 'Started',
                 style:  TextStyle(
                     fontSize: 20,
                     fontWeight: FontWeight.w800
                 ),
               )
           ),
         )

        ],
      ),
    );
  }
}
