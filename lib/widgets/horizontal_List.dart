import 'package:flutter/material.dart';
// import 'file:///C:/Users/Salah/StudioProjects/global_market/lib/helper/style.dart';
import 'package:global_market/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
class HorizontalList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      child: ListView(
        scrollDirection: Axis.horizontal ,
        children: <Widget>[
          Category(
            image_Location: 'images/3.JFIF',
            image_Caption: LocaleKeys.Computers.tr(),
          ),
          Category(
            image_Location: 'images/4.JFIF',
            image_Caption: LocaleKeys.phones.tr(),
          ),
          Category(
            image_Location: 'images/1.JFIF',
            image_Caption: LocaleKeys.accessories.tr(),
          ),
          Category(
            image_Location: 'images/1.JFIF',
            image_Caption: LocaleKeys.salah.tr(),
          ),

        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String image_Location;
  final String image_Caption;

  Category({this.image_Location, this.image_Caption}) ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
          onTap: (){},
          child: Container(
            decoration: BoxDecoration(shape:BoxShape.circle),
            width: 100,
            child: ListTile(
              title: Image.asset(
                image_Location,
                width: 100,
                height: 60,
                fit: BoxFit.fill,

              ),
              subtitle: Container(
                alignment: Alignment.topCenter,
                child: Text(image_Caption,style:new TextStyle(fontSize:12,color: Colors.black),),),

            ),
          )),
    );
  }
}

