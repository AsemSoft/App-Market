import 'dart:io';
import 'dart:ui';
import 'package:global_market/main.dart';
import 'package:global_market/screens/admin/manageProduct.dart';
import 'package:global_market/screens/home1.dart';
import 'package:global_market/translations/locale_keys.g.dart';
import 'package:path/path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:global_market/constants.dart';
import 'package:global_market/models/product.dart';
import 'package:global_market/services/store.dart';
import 'package:global_market/widgets/CustomTextField.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easy_localization/easy_localization.dart';

class EditProduct extends StatefulWidget {
  static String id = 'EditProduct';
  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  String _name, _price, _description, _category, _img;
  File _image;
  final picker = ImagePicker();
  Future getImage(ImageSource src) async {
    final pickedFile = await picker.getImage(source: src);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('لايوجد صورة ');
      }
    });
  }
  String img;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _store = Store();
  @override
  Widget build(BuildContext context) {
    final fileName = _image != null ? basename(_image.path) : 'No file';

    Product products = ModalRoute.of(context).settings.arguments;
    img=products.pImg;
    print('hhhhhhh$img');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(LocaleKeys.Edit_Product_Screen.tr(),style: TextStyle(color: Colors.black),),
        iconTheme: IconThemeData(color: Colors.black),

      ),
      body: Form(
        key: _globalKey,
        child: ListView(

          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * .05,
            ),
            Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // حقل الاسم
                CustomTextField(
                  icon: Icons.near_me,
                  hint: LocaleKeys.Product_name.tr(),
                  value: products.pName,
                  onClick: (value) {
                    _name = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                // حقل السعر
                CustomTextField(
                  keyType: TextInputType.number,
                  icon: Icons.money,
                  hint: LocaleKeys.Product_price.tr(),
                  value: products.pPrice,
                  onClick: (value) {
                    _price = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                // حقل التفاصيل
                CustomTextField(
                  icon: Icons.details,
                  hint: LocaleKeys.Product_description.tr(),
                  value: products.pDescription,
                  onClick: (value) {
                    _description = value;
                  },
                ),
                //

                // حقل الصنف

                SizedBox(
                  height: 10,
                ),
                // حقل الصورة
                CustomTextField(
                  icon: Icons.image,
                  hint: LocaleKeys.Product_image.tr(),
                  value: products.pImg,
                  onClick: (value) {
                    _img = value;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: GestureDetector(
                    onTap: () {
                      // var ad = AlertDialog(
                      //   title: Text(LocaleKeys.Choose_an_image.tr()),
                      //   content: Container(
                      //     height: 150,
                      //     child: Column(
                      //       children: [
                      //         Divider(color: Colors.black),
                      //         Container(
                      //           color: Colors.teal,
                      //           child: ListTile(
                      //             leading: Icon(Icons.image),
                      //             title: Text(LocaleKeys.Gallery.tr()),
                      //             onTap: () {
                      //               getImage(ImageSource.gallery);
                      //               Navigator.pop(context);
                      //             },
                      //           ),
                      //         ),
                      //         SizedBox(height: 10),
                      //         Container(
                      //           color: Colors.teal,
                      //           child: ListTile(
                      //             leading: Icon(Icons.image),
                      //             title: Text(LocaleKeys.Camera.tr()),
                      //             onTap: () {
                      //               getImage(ImageSource.camera);
                      //               Navigator.pop(context);
                      //             },
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // );
                      // showDialog(context: context, builder: (c) => ad);
                    },
                    child: Container(
                      color:  Colors.blueGrey,
                      height: MediaQuery.of(context).size.height * .3,
                      width: MediaQuery.of(context).size.width * .84,
                      child: Image(
                              fit: BoxFit.fill,
                              image: AssetImage(products.pImg),
                            )
                          // : Image.network("/${products.pImg}"),
                    ),
                  ),
                ),
                //SizedBox(height: 20,),
                //زر تعديل
                ButtonTheme(

                  minWidth: MediaQuery.of(context).size.width * .84,
                  height: MediaQuery.of(context).size.height * .07,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  )),
                  child: MaterialButton(
                    color: Home1.changColor(),
                    onPressed: () async{

                        print('empty');

                        if (_globalKey.currentState.validate()) {
                          _globalKey.currentState.save();
                          Container alertDialog = Container(
                            child: AlertDialog(
                              actions: <Widget>[
                                MaterialButton(
                                  color: MyApp.tm==ThemeMode.light?kColor:Colors.grey,
                                  onPressed: ()
                                  {
                                    if(_name.isEmpty==true||_description==''||_img==''||_price==''){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(LocaleKeys.Field_is_empty.tr())));

                                  }
                                    else{
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(LocaleKeys.Edit_is_Done.tr())));
                                    _store.editProduct(({
                                      kProductName: _name,
                                      kProductPrice: _price,
                                      kProductDescription: _description,
                                      kProductImg: products.pImg,
                                    }), products.pId);
                                    Navigator.pop(context);
                                    Navigator.pop(context);

                                  }},

                                  child: Text(LocaleKeys.Yes.tr(),
                                  ),
                                ),
                                MaterialButton(
                                  color: MyApp.tm==ThemeMode.light?kColor:Colors.grey,                                  onPressed: ()
                                  {
                                    Navigator.pop(context);
                                  },

                                  child: Text(
                                    LocaleKeys.No.tr(),
                                  ),
                                ),
                              ],
                              content: Container(
                                height: 60,
                                child: Text(
                                  LocaleKeys.Do_you_want_to_edit.tr(),
                                  style: TextStyle(color: Colors.black87, fontSize: 16),
                                ),
                              ),
                              title: Row(
                                children: [
                                  Text(LocaleKeys.Warning_Edit.tr()),
                                  SizedBox(width: 20),
                                  Icon(Icons.warning,color: MyApp.tm==ThemeMode.light?kColor:Colors.grey,),
                                ],
                              ),
                            ),
                          );
                          await showDialog(
                              context: context,
                              builder: (context) {
                            return alertDialog;
                          });

                          print('done');
                        }

                    },
                    child: Text(LocaleKeys.Edit_Product.tr(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
