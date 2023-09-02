import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/register_page.dart';
import 'package:chat_app/screens/started_screen.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../helper/const & functions.dart';

class LoginPage extends StatefulWidget {

  static String id='LoginPage';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  bool isLoading=false;

  String? email;
  String? password;
  bool obscureText=true;


// now i created global key with type form
  GlobalKey<FormState> formKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Form(
        // this give me an access in every thing in this form widget
        key: formKey,
        child: Scaffold(
         body:  SingleChildScrollView(
           child: Column(
             children: [
               Container(
                 alignment: Alignment.topLeft,
                 padding: const EdgeInsets.only(
                     top: 50,
                     //bottom: 30,
                     left: 20
                 ),
                 //icon to navigate me to the back screen
                   child: GestureDetector(
                     child: Image.asset(
                       'assets/Arrow---Left.png',
                     ),
                     onTap: () {
                       Navigator.pushReplacement(
                           context,
                           MaterialPageRoute(
                               builder: (context) => const StartedScreen()));
                     },
                   ),
                 ),
                   Row(
               children: [
                    const Column(
                   children: [
                     //email text field
                     Row(
                       children: [
                         Padding(
                           padding:  EdgeInsets.only(
                             bottom: 10
                           ),
                           child: Text(
                             ' Hello, Welcome Back',
                             style: TextStyle(
                                 fontSize: 25,
                                 fontWeight: FontWeight.bold
                             ),
                           ),
                         )
                       ],
                     ),
                     //password text field
                     Row(
                       children: [
                         Text(
                           ' Happy to see you again, to use\n your account please login first.',
                           style: TextStyle(
                             fontSize: 18,
                           ),
                         ),
                       ],
                     ),
                   ],
                 ),
                    Column(
                   children: [
                     Image(
                         image: const AssetImage('assets/Dayflow Sitting.png'),
                       width: MediaQuery.of(context).size.width*0.3,
                       height: 200,
                     )
                   ],
                 ),
               ],
                   ),
               //email text field
               Container(
                 alignment: Alignment.topLeft,
                 margin:const EdgeInsets.only(left: 30),
                 child:const Text(
                     'Email Address',
                   style: TextStyle(
                     fontSize: 18,
                   ),
                 ),
               ),
               Container(
                 margin:const EdgeInsets.all(10),
                 padding:const EdgeInsets.only(bottom: 25),
                 child: CustomFormTextField(
                   type: TextInputType.emailAddress,
                   action: TextInputAction.next,
                   icon: const Icon(Icons.email),
                   onChanged: (data) {
                     email = data;
                   },
                 )
               ),
               //password text field
               Container(
                 alignment: Alignment.topLeft,
                 margin:const EdgeInsets.only(left: 30),
                 child:const Text(
                   'Password',
                   style: TextStyle(
                     fontSize: 18,
                   ),
                 ),
               ),
               Container(
                 margin:const EdgeInsets.all(10),
                 padding:const EdgeInsets.only(bottom: 40),
                 child: CustomFormTextField(
                   type: TextInputType.visiblePassword,
                   action: TextInputAction.done,
                   obsecureText: obscureText,
                   suffixIcon: IconButton(
                     onPressed: () {
                       obscureText = !obscureText;
                       setState(() {});
                     },
                     icon: obscureText
                         ? Icon(Icons.visibility_off)
                         : Icon(Icons.visibility),
                   ),
                   icon: const Icon(Icons.lock),
                   onChanged: (data) {
                     password = data;
                   },
                 )
               ),
               // login button
               CustomButton(
                 text: 'Login',
                 onTap: () async {
                   if (formKey.currentState!.validate()) {
                     // CircularProgressIndicator will appear
                     isLoading=true;
                     setState(() {});
                     try{
                       await userLogin();
                       Navigator.pushNamed(context,  ChatPage.id, arguments: email);
                     }on FirebaseAuthException catch(e){
                       if (e.code == 'user-not-found') {
                         showSnackBar(context, message: 'No user found for that email ⚠');
                       }
                       else if (e.code == 'wrong-password') {
                         showSnackBar(context, message: 'Wrong password provided for that user ⚠');
                       }
                     }catch(e){
                       showSnackBar(context, message: 'There was an error !');
                     }
                     // CircularProgressIndicator will disappear

                     isLoading=false;
                     setState(() {});
                   }
                 },
               ),
               // login button
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   const Text(
                     'Don\'t have an account ? ',
                     style: TextStyle(
                       fontSize: 18,

                     ),
                   ),
                   GestureDetector(
                     child:const Text(
                       'Register',
                       style: TextStyle(
                         fontSize: 15,
                         fontWeight: FontWeight.w800,
                         color: Color(0xff4d4b4b)
                       ),
                     ),
                     onTap: () {
                       Navigator.pushNamed(context, RegisterPage.id);
                        },
                   ),
                 ],
               )
             ],
           ),
         )
        ),
      ),
    );
  }

   Future<void> userLogin () async {
     //   UserCredential is A structure containing a User,
     //       the OperationType, and the provider ID.operationType could be
     // OperationType.SIGN_IN for a sign-in operation, OperationType.
     // LINK for a linking operation and OperationType.REAUTHENTICATE for a
     // reauthentication operation.
     UserCredential user= await
     FirebaseAuth.instance.signInWithEmailAndPassword(
       email: email! ,
       password: password! ,
     );
   }


}
