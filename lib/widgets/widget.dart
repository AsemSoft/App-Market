import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_market/screens/users/allCategory.dart';
import 'package:global_market/screens/users/allPages.dart';
import 'package:global_market/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
List _listImage = [
  'images/product_Image/Huawei/n4e.jpeg',
  'images/product_Image/Huawei/n4e.jpeg',
 'images/product_Image/Huawei/y7a.jpeg',
 'images/product_Image/Huawei/y9s.jpeg',
];
// الصور المتحركة
// CarouselSlider(
//     options: CarouselOptions(
//         height: 200,
//         initialPage: 0,
//         enlargeCenterPage: true,
//         autoPlay: true,
//         pauseAutoPlayOnTouch: true,
//         autoPlayInterval: Duration(seconds: 1),
//         onPageChanged: (index, _) {
//           setState(() {
//             curentIndix = index;
//           });
//         }
//
//     ),
//     items: _listImage.map((imageUrl) {
//       return Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height * .5,
//         color: Colors.white,
//         // child: AssetImage(imageUrl, fit: BoxFit.fill),
//       );
//     }).toList()),
// SizedBox(
//   height: 15,
// ),
// //الدوائر تحت الصور المتحركة
// Row(
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: [
//     buildContainer(0),
//     buildContainer(1),
//     buildContainer(2),
//   ],
// ),


// Container buildContainer(index) {
//   return Container(
//     height: 10,
//     width: 10,
//     margin: EdgeInsets.symmetric(horizontal: 3),
//     decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: curentIndix == index ? Colors.black : Colors.white70),
//   );
// }


// floatingActionButton: FloatingActionButton(
//   child: Icon(
//     Icons.add_a_photo,
//     color: Colors.black,
//   ),
//   backgroundColor: kInputFailedColor,
//   onPressed: () {
//     var ad = AlertDialog(
//       title: Text('اختر الصورة من  '),
//       content: Container(
//         height: 150,
//         child: Column(
//           children: [
//             Divider(color: Colors.black),
//             Container(
//               color: Colors.teal,
//               child: ListTile(
//                 leading: Icon(Icons.image),
//                 title: Text('معرض الصور'),
//                 onTap: () {
//                   getImage(ImageSource.gallery);
//                   Navigator.pop(context);
//                 },
//               ),
//             ),
//             SizedBox(height: 10),
//             Container(
//               color: Colors.teal,
//               child: ListTile(
//                 leading: Icon(Icons.image),
//                 title: Text('الكاميرا'),
//                 onTap: () {
//                   getImage(ImageSource.camera);
//                   Navigator.pop(context);
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//     showDialog(context: context, builder: (context) => ad);
//   },
// ),.

Widget mainPart(context) {
  return Row(
    children: [
      GestureDetector(
        onTap: () {
          AllPages.titleName = LocaleKeys.All_Category.tr();
          Navigator.pushNamed(context, AllCategories.id);
        },
        child: Column(
          children: [
            ClipOval(
                child: Container(
                    height: 70,
                    width: 70,
                    color: Colors.white70,
                    child: Icon(
                      Icons.category,
                      size: 60,
                    ))),
            Text(LocaleKeys.All_Category.tr())
          ],
        ),
      ),
      SizedBox(width: 15),
      GestureDetector(
        onTap: () {
          AllPages.selectedCategory = 'Computers';
          AllPages.brandName = ['Toshiba', 'Acer', 'Dell', 'HP'];
          AllPages.titleName = LocaleKeys.Computers.tr();
          Navigator.pushNamed(context, AllPages.id);
        },
        child: Column(
          children: [
            ClipOval(
                child: Container(
                    height: 70,
                    width: 70,
                    color: Colors.white70,
                    child: Icon(
                      Icons.computer,
                      size: 60,
                    ))),
            Text(LocaleKeys.Computers.tr())
          ],
        ),
      ),
      SizedBox(width: 15),
      GestureDetector(
        onTap: () {
          AllPages.selectedCategory = 'Phones';
          AllPages.brandName = ['Redmi', 'Samsung', 'LT', 'Huawei'];
          AllPages.titleName = LocaleKeys.phones.tr();
          Navigator.pushNamed(context, AllPages.id);
        },
        child: Column(
          children: [
            ClipOval(
                child: Container(
                    height: 70,
                    width: 70,
                    color: Colors.white70,
                    child: Icon(
                      Icons.phone_android,
                      size: 60,
                    ))),
            Text(LocaleKeys.phones.tr()),
          ],
        ),
      ),
      SizedBox(width: 15),
      GestureDetector(
        onTap: () {
          AllPages.selectedCategory = 'Watches';
          AllPages.brandName = ['Sonic', 'Casio', 'Redmi', 'Samsung'];
          AllPages.titleName = LocaleKeys.Watches.tr();
          Navigator.pushNamed(context, AllPages.id);
        },
        child: Column(
          children: [
            ClipOval(
                child: Container(
                    height: 70,
                    width: 70,
                    color: Colors.white70,
                    child: Icon(
                      Icons.watch,
                      size: 60,
                    ))),
            Text(LocaleKeys.Watches.tr())
          ],
        ),
      ),
      SizedBox(width: 15),
      GestureDetector(
        onTap: () {
          AllPages.selectedCategory = 'Accessories';
          AllPages.brandName = ['LT', 'Remax', 'Redmi', 'Samsung'];
          AllPages.titleName = LocaleKeys.accessories.tr();
          Navigator.pushNamed(context, AllPages.id);
        },
        child: Column(
          children: [
            ClipOval(
                child: Container(
                    height: 70,
                    width: 70,
                    color: Colors.white70,
                    child: Icon(
                      Icons
                          .local_convenience_store_rounded,
                      size: 60,
                    ))),
            Text(LocaleKeys.accessories.tr())
          ],
        ),
      ),
      SizedBox(width: 15),
//Row(children:<Widget>[]),
    ],
  );
}