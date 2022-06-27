import 'package:flutter/material.dart';
import 'package:global_market/constants.dart';
import 'package:global_market/screens/home1.dart';
import 'package:global_market/screens/login_screen.dart';
import 'package:global_market/screens/signup_screen.dart';
import 'package:global_market/screens/users/cartScreen.dart';

class  MyAccount extends StatefulWidget {
static String id = 'MyAccount';
  @override
  _State createState() => _State();
}

class _State extends State<MyAccount> {
  int _bottomBarIndex=1;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Home1.changColor() ,
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.white,
        unselectedItemColor: kUnActiveColor,
        currentIndex: _bottomBarIndex,
        onTap: (value) {
          if(value==0){
            Navigator.pushNamed(context, CartScreen.id);
          }
          else if(value==1){
            _bottomBarIndex = value;
            Navigator.pushNamed(context, Home1.id);
            _bottomBarIndex = value;
          }
          setState(() {
            _bottomBarIndex = value;
          });
        },

        items: [
          BottomNavigationBarItem(
              title: Text('سلة التسوق'), icon: Icon(Icons.shopping_cart)),
          // BottomNavigationBarItem(
          //     title: Text('الرئيسية'), icon: Icon(Icons.home)),
          BottomNavigationBarItem(
              title: Text('الاقسام'), icon: Icon(Icons.category)),
          BottomNavigationBarItem(
              title: Text('معلومات'), icon: Icon(Icons.info)),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 15,
          ),
          //الخط المتحرك
          SizedBox(
            height: 15,
          ),

          ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
            onPressed:(){ Navigator.pushNamed(context, SignupScreen.id);},
            child: Container(
                alignment: Alignment.center,
                height: 60,
                width: MediaQuery.of(context).size.width*.9,
                child: Text('Signup',style: TextStyle(fontWeight:FontWeight.bold,fontSize:18,color: Colors.black),)),
          ),
          SizedBox(height: 10,),
          ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
            onPressed:(){ Navigator.pushNamed(context, LoginScreen.id);},
            child: Container(
                alignment: Alignment.center,
                height: 60,
                width: MediaQuery.of(context).size.width*.9,
                child: Text('Login',style: TextStyle(fontWeight:FontWeight.bold,fontSize:18,color: Colors.black),),
            ),
          ),
          SizedBox(height: 10,),




        ],
      )
    );
  }
}
