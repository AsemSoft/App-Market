import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_market/models/users.dart';
import 'package:global_market/provider/modelHud.dart';
import 'package:global_market/screens/login_screen.dart';
import 'package:global_market/services/store.dart';
import 'package:global_market/translations/locale_keys.g.dart';
import 'package:global_market/widgets/CustomTextField.dart';
import 'package:global_market/services/auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:global_market/screens/users/homepage.dart';

class SignupScreen extends StatefulWidget {
  static String id = 'SignupScreen';

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  String _email, _password,_userName,_phone,userPic;
  // String _typeUser;
  final _auth = Auth();
  final _store = Store();
  List listItems=['مستخدم مدير','مستخدم عادي'];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(

      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModalHud>(context).isLoading,
        child: Form(
          key: _globalKey, // من اجل التحقق
          child: ListView(
            children: <Widget>[
              //icon and title
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Image(
                          image: AssetImage('images/icons/buy.png'),
                        ),
                        Positioned(
                          bottom: -4,
                          child: Text(
                            LocaleKeys.title.tr(),
                            style: TextStyle(
                                fontFamily: 'pacifico',
                                fontSize: 25
                            ),
                          ),
                        ),
                      ]
                  ),
                ),
              ),
              //icon and font
              SizedBox(height: height * .05,),
              //Name
              CustomTextField(
                value: '',
                onClick: (value) {
                  _userName=value;
                },
                hint: LocaleKeys.enter_your_name.tr(),
                icon: Icons.person,
              ),
              SizedBox(
                height: height * .02,
              ),
              //Email
              CustomTextField(
                value: '',
                onClick: (value) {
                  _email = value;
                },
                hint: LocaleKeys.enter_your_email.tr(),
                icon: Icons.email,
              ),
              SizedBox(
                height: height * .02,
              ),
              //password
              CustomTextField(

                onClick: (value) {
                  _password = value;
                },
                hint: LocaleKeys.enter_your_password.tr(),
                icon: Icons.lock,
              ),
              SizedBox(
                height: height * .02,
              ),
              //phone
              CustomTextField(
                keyType: TextInputType.phone,
                onClick: (value) {
                  _phone = value;
                },
                hint: LocaleKeys.Enter_phone_number.tr(),
                icon: Icons.phone_android_outlined,
              ),
              SizedBox(
                height: height * .02,
              ),
              // لتحديد نوع المستخدم
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(30,22,30,22),
              //   child: Container(
              //     color: kInputFailedColor,
              //     height: 50,
              //     alignment: Alignment.center,
              //     child: DropdownButton(
              //       isExpanded: false,
              //       underline: Container( height: 0, color: Colors.black,),
              //       dropdownColor: kInputFailedColor,
              //       hint: Text('اختر نوع المستخدم'),
              //       icon: Icon(Icons.arrow_drop_down),
              //       style: TextStyle(color: Colors.black,fontSize:16,fontWeight:FontWeight.w500),
              //       onChanged: (value)
              //       {
              //         setState(() {
              //           _typeUser=value;
              //         });
              //       },
              //       items:listItems.map((valueItem) {
              //         return DropdownMenuItem
              //           (
              //             value: valueItem,
              //             child :Text(valueItem),
              //           );
              //       }).toList(),
              //       value: _typeUser,
              //     ),
              //   ),
              // ),
              // button_login
              //Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 140),
                child: Builder(
                  builder: (context) =>
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                        ),
                        onPressed: () async {
                          final modalHud = Provider.of<ModalHud>(context,listen: false);
                          modalHud.changeisLoading(true);
                          if (_globalKey.currentState.validate())
                          {
                            _globalKey.currentState.save();
                            try {

                              final authResult = await _auth.signup( _email, _password);
                              await _store.addUser(Users(
                                  name: _userName,
                                  pass: _password,
                                  email: _email,
                                  userPhone:_phone,
                                  pic: userPic));
                              modalHud.changeisLoading(false);
                              Navigator.pushNamed(context, HomePage.id);
                              print(authResult.user.uid);
                              print(_email);
                              print(_password);
                            } catch (e) {
                              modalHud.changeisLoading(false);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                    e.message
                                ),
                              ));
                            }
                          } // end if
                          modalHud.changeisLoading(false);
                        },
                        color: Colors.black,
                        child: Text(
                          LocaleKeys.signup.tr(),
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                      ),
                ),
              ),
              SizedBox(height: height * .04,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(LocaleKeys.Do_you_account.tr(), style: TextStyle(color: Colors.white, fontSize: 16),),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                    child: Text(''+LocaleKeys.login.tr(),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16
                      ),
                    ),
                  )
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}