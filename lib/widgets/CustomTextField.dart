import 'package:flutter/services.dart';
import 'package:global_market/constants.dart';
import 'package:flutter/material.dart';
import 'package:global_market/helper/style.dart';
import 'package:global_market/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Function onClick;
  final String value;
  final TextInputType keyType;
  String _errorMessage(String srt)
  {
    switch(hint)
    {
      case 'Enter your name' : return 'Name is empty';
      case 'Enter your email':return 'Email is empty';
      case 'Enter your password': return 'Password is empty';
      case 'Enter phone number': return 'Password is empty';
      case 'أدخل اسمك': return 'هذا الحقل مطلوب';
      case 'أدخل بريدك الالكتروني': return 'هذا الحقل مطلوب';
      case 'أدخل كلمة المرور': return 'هذا الحقل مطلوب';
      case 'أدخل رقم الهاتف': return 'هذا الحقل مطلوب';

      case 'Product name': return 'This field is required';
      case 'Product price': return 'This field is required';
      case 'Product description': return 'This field is required';
      case 'Product image': return 'This field is required';
      case 'اسم المنتج': return 'هذا الحقل مطلوب';
      case 'وصف المنتج': return 'هذا الحقل مطلوب';
      case 'سعر المنتج': return 'هذا الحقل مطلوب';
      case 'صورة المنتج': return 'هذا الحقل مطلوب';

    }
    return srt;

  }

  CustomTextField({@required this.onClick, @required this.icon, @required this.hint, this.value,this.keyType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
       initialValue: value,
          validator: (String value) {
            if (value.isEmpty) {
              return _errorMessage(hint);
            }else{
              return null;
            }

          },
          keyboardType: keyType,

          onSaved: onClick,
          obscureText: hint==LocaleKeys.enter_your_password.tr()?true :false,
          cursorColor: black,
          decoration: InputDecoration(
              hintText: hint,
              prefixIcon: Icon(
                icon,
                color: kColor,
              ),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                      color: Colors.black,
                  )
              ),

              // focusedBorder: OutlineInputBorder(
              //     borderRadius: BorderRadius.circular(20),
              //     borderSide: BorderSide(
              //         color: kMainColor,
              //     )
              // ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                      color: Colors.black
                  )
              )

          )
      ),
    );
  }
}