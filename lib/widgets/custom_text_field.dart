import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {

  Icon? icon;
  // i used it not VoidCallback, cuz i will return String argument and VoidCallback is a void func
  Function(String)? onChanged;
  IconButton? suffixIcon;
  bool obsecureText;
  TextInputAction action;
  TextInputType type;



  CustomFormTextField({
     required this.icon,
     required this.onChanged,
     required this.action,
     required this.type,
     this.suffixIcon,
     this.obsecureText=false,
   });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecureText,
      textInputAction: action,
      keyboardType: type,
      validator: (data){
        if(data!.isEmpty ){
          return ' This Field is required !';
        }else if(data.length <8){
          return 'Must be at least 8 character!';
        }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: icon,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            borderSide: BorderSide(
                color: Color(0xff6B6B6B)
            )
        ),

      ),
    );
  }
}
