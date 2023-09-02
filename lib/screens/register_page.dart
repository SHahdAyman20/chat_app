import 'dart:io';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../helper/const & functions.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'login_page.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPage extends StatefulWidget {

  static String id='RegisterPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  bool isLoading=false;
  String? email;
  String? password;
  bool obsecureText=true;


// now i created global key with type form
  GlobalKey<FormState> formKey=GlobalKey();
  File? selectedImage;



  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        // i used form widget to check the validation of textField
        body:  Form(
          // this give me an access in every thing in this form widget
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                //icon to navigate me to the back screen
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(
                      top: 50,
                      //bottom: 30,
                      left: 20
                  ),
                  child: GestureDetector(
                    child: Image.asset(
                      'assets/Arrow---Left.png',
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginPage()));
                    },
                  ),
                ),
                Row(
                  children: [
                    //this column have 2 rows => text in bold and thin text
                    const Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
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
                        Row(
                          children: [
                            Text(
                              ' Happy to see you, to contact\neveryone please register first.',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // this column contain image
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
                    padding: const EdgeInsets.only(bottom: 20),
                    child: CustomFormTextField(
                      type: TextInputType.emailAddress,
                      action: TextInputAction.next,
                      icon: const Icon(Icons.email),
                      onChanged: (data){
                        email=data;
                      },
                    ),

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
                    padding: const EdgeInsets.only(bottom: 30),
                    child: CustomFormTextField(
                      type: TextInputType.visiblePassword,
                      action: TextInputAction.done,
                      obsecureText: obsecureText,
                      suffixIcon: IconButton(
                        onPressed: () {
                          obsecureText = !obsecureText;
                          setState(() {});
                        },
                        icon: obsecureText
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                      ),
                      onChanged: (data){
                        password=data;
                      },
                      icon: const Icon(Icons.lock),

                    )
                ),
                // register button
                CustomButton(
                  text: 'Register',
                  onTap: () async {
                    if(formKey.currentState!.validate()){
                      // CircularProgressIndicator will appear
                      isLoading=true;
                      setState(() {});
                      try{
                        await userRegister ();
                        showSnackBar(context, message: 'The account created successfully ✅');
                        Navigator.pop(context);
                      }on FirebaseAuthException catch(e){
                        if (e.code == 'weak-password') {
                          showSnackBar(context, message: 'The password provided is too weak ⚠');
                        }
                        else if (e.code == 'email-already-in-use') {
                          showSnackBar(context, message: 'The account already exists for that email ⚠');
                        }
                      }catch(e){
                        print(e);
                        showSnackBar(context, message: 'There was an error');
                      }
                      // CircularProgressIndicator will disappear

                      isLoading=false;
                      setState(() {});

                    }else{

                    }
                  },
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account ? ',
                      style: TextStyle(
                        fontSize: 18,

                      ),
                    ),
                    GestureDetector(
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: Color(0xff4d4b4b)
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                )
              ],
        )
          ),
        ),
      ),
    );
  }

  Future<void> userRegister () async {
    //   UserCredential is A structure containing a User,
    //       the OperationType, and the provider ID.operationType could be
    // OperationType.SIGN_IN for a sign-in operation, OperationType.
    // LINK for a linking operation and OperationType.REAUTHENTICATE for a
    // reauthentication operation.
    UserCredential user = await
    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }



}
