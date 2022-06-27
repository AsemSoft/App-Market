import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_market/constants.dart';
import 'package:global_market/main.dart';
import 'package:global_market/models/users.dart';
import 'package:global_market/provider/adminMode.dart';
import 'package:global_market/provider/modelHud.dart';
import 'package:global_market/screens/home1.dart';
import 'package:global_market/screens/signup_screen.dart';
import 'package:global_market/screens/admin/adminHome.dart';
import 'package:global_market/screens/users/homepage.dart';
import 'package:global_market/services/store.dart';
import 'package:global_market/translations/locale_keys.g.dart';
import 'package:global_market/widgets//CustomTextField.dart';
import 'package:global_market/services/auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';
  static String email ='';
  static List<Users> user = [];
  @override
  _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String _email, _password;
  final _auth = Auth();
  final _store = Store();
  bool isAdmin = false;
  var typeUsers = kUserType;
  final adminPassword = 'admin1234';
  bool keepMe = false;

  List<Users> _user = [];
  // var __typeUser;
  @override
  Widget build(BuildContext context) {
    // Users users =ModalRoute.of(context).settings.arguments;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData)
          {
            for (var doc in snapshot.data.docs) {
              _user.add(
                  Users(
                userId: doc.id,
                name: doc[kUsersName],
                pass: doc[kPass],
                email: doc[kEmail],
                pic: doc[kUserImg],
                userPhone: doc[kPhone]
              ));

            }
            LoginScreen.user=_user;

            return ModalProgressHUD(
                inAsyncCall: Provider.of<ModalHud>(context).isLoading, //اظهار انتظار الدخول
                child: Form(
                  key: _globalKey, // من اجل التحقق
                  child: ListView(
                    children: <Widget>[
                      //start icon and font
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
                                        fontFamily: 'pacifico', fontSize: 25),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                      //end icon and font

                      SizedBox(
                        height: 40,
                      ),
                      //start textEmail
                      CustomTextField(
                        value: '',
                        onClick: (value) {
                          _email = value;
                          LoginScreen.email=value;
                        },
                        hint: LocaleKeys.enter_your_email.tr(),
                        icon: Icons.email,
                      ),
                      //end textEmail
                      SizedBox(
                        height: height * .02,
                      ),
                      //start password
                      CustomTextField(
                        value: '',
                        onClick: (value) {
                          _password = value;
                        },
                        hint: LocaleKeys.enter_your_password.tr(),
                        icon: Icons.lock,
                      ),
                      //end password
                      // تذكرني
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 30,right: 30),
                      //   child: Row(
                      //     children: [
                      //       Theme(
                      //         data: ThemeData(
                      //             unselectedWidgetColor: Colors.white70),
                      //         child: Checkbox(
                      //
                      //           checkColor: Colors.black,
                      //           value: keepMe,
                      //           onChanged: (value) {
                      //             setState(() {
                      //               keepMe = value;
                      //             });
                      //           },
                      //         ),
                      //       ),
                      //       Text(LocaleKeys.Remember_Me.tr()),
                      //     ],
                      //   ),
                      // ),
                      SizedBox(
                        height: height * .03,
                      ),
                      //start button login
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 140),
                        child: Builder(
                          builder: (context) =>
                              MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            onPressed: () {
                              // if (keepMe == true) {
                              //   keepUserLogIn();
                              // }
                              _validate(context);
                            },
                            color: Colors.black,
                            child: Text(
                              LocaleKeys.login.tr(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      //end button_login
                      SizedBox(
                        height: height * .03,
                      ),
                      //start text_label
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            LocaleKeys.Do_not_have_account.tr(),
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          //end text don't have
                          // start label signup
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, SignupScreen.id);
                            },
                            //start text don't have
                            child: Text(
                              ' '+LocaleKeys.signup.tr(),
                              style:
                              TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ),
                          //end label signup
                        ],
                      ),
                      // end text_label
                      // اختيار المستخدم
                      Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              //start text admin
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Provider.of<AdminMode>(context, listen: false).changeIsAdmin(true);
                                  },
                                  child: Text(
                                    LocaleKeys.As_admin.tr(),
                                    textAlign: TextAlign.center,
                                    style: MyApp.tm==ThemeMode.light?TextStyle(color:Provider.of<AdminMode>(context).isAdmin ? kColor: Colors.white, fontSize:16):TextStyle(color:Provider.of<AdminMode>(context).isAdmin ? Colors.grey: Colors.white, fontSize:16)

                                    ,),
                                ),
                              ),
                              //end text admin
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Provider.of<AdminMode>(context, listen: false).changeIsAdmin(false);
                                  },
                                  child: Text(
                                    LocaleKeys.As_customer.tr(),
                                    textAlign: TextAlign.center,
                                    style:MyApp.tm==ThemeMode.light? TextStyle(color: Provider.of<AdminMode>(context).isAdmin ? Colors.white : kColor, fontSize: 16):TextStyle(color: Provider.of<AdminMode>(context).isAdmin ? Colors.white : Colors.grey, fontSize: 16),
                                  ),
                                ),
                              ),
                              //end
                            ]),
                      )
                    ],
                  ),
                ),
              );
          }
          else{
          return  Center(child: Text(LocaleKeys.Loading.tr()));
          }  }
      )
    );
  }

  void _validate(BuildContext context) async {
    final modalHud = Provider.of<ModalHud>(context, listen: false);
    modalHud.changeisLoading(true);
    if (_globalKey.currentState.validate()) {
      _globalKey.currentState.save();
      if (Provider.of<AdminMode>(context, listen: false).isAdmin)
      {
        // for(var email in _user)
        // {
        // if(_email==email.email)
        //    __typeUser =email.userType;
        // }
        // if (__typeUser== 'مستخدم مدير')
        if (_password==adminPassword)
        {
          try {
            await _auth.signin(_email, _password);
            Navigator.pushNamed(context, AdminHome.id);
          } catch (e) {
            modalHud.changeisLoading(false);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message),));
          }
        }
        // else if(__typeUser== 'مستخدم عادي'){
        //   Home1.isLoggedIn=true;
        // Navigator.pushNamed(context, Home1.id);
        // }
        else{
          modalHud.changeisLoading(false);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('wrong'),
          ));
        }
      }
      else {
        try {
          await _auth.signin(_email, _password);

          for(var email in _user)
            {
            if(_email==email.email){
              Home1.email=email.email;
              Home1.userName=email.name;
              Home1.userPhone=email.userPhone;
              Home1.userImg=email.pic;
            }

            }
          Home1.isLoggedIn=true;
          Navigator.pushNamed(context, HomePage.id );
        } catch (e) {
          modalHud.changeisLoading(false);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.message),
          ));
        }
      }
    }
    modalHud.changeisLoading(false);
  }
  // void keepUserLogIn() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.setBool(kKeepLoggedIn, keepMe);
  // }
}
