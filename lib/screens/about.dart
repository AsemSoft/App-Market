import 'dart:ui';
import 'package:global_market/translations/locale_keys.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
class About extends StatefulWidget {
  static String id = 'About';

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.About_us.tr(),style: TextStyle(color: Colors.black),),
          iconTheme: IconThemeData(color: Colors.black),

        ),
        body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(LocaleKeys.welcome.tr(),style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold)),
            SizedBox(height: 30,),
            Text(LocaleKeys.Design_By.tr(),style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold)),
            SizedBox(height: 10,),
            Text(LocaleKeys.SalahTaher.tr(),style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold)),
            Text(LocaleKeys.Asem_Ahmed.tr(),style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold)),
            Text(LocaleKeys.Ahmed_Abduallah.tr(),style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold)),
            Text(LocaleKeys.Alaa_Adel.tr(),style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold)),
            Text(LocaleKeys.Zaid_Ali.tr(),style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold)),
            SizedBox(height: 20,),
            Text(LocaleKeys.Supervisor.tr(),style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold)),
            SizedBox(height: 10,),
            Text(LocaleKeys.Dr_Mohemmed.tr(),style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold)),
          ],
        ),
        )
    );
  }


}
