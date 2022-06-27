import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' ;
import 'package:global_market/constants.dart';
import 'package:global_market/translations/locale_keys.g.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_market/models/product.dart';
import 'package:global_market/services/store.dart';
import 'package:global_market/widgets/CustomTextField.dart';
import 'package:path/path.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:easy_localization/easy_localization.dart';

class AddProduct extends StatefulWidget {
  static String id = 'AddProduct';


  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

  UploadTask task;
  var url;
  String _name, _price, _description, _category, brand;
  File _image;
  List listItems = [LocaleKeys.Computers.tr(), LocaleKeys.phones.tr(), LocaleKeys.accessories.tr() ];
  List listBrand=['Samsung', 'Redmi', 'Huawei', 'LT'];
  final picker = ImagePicker();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _store = Store();
   List<File>__image = <File>[];
   List<Asset>multiImages =<Asset>[];
  Future getImage(ImageSource src) async {
    final pickedFile = await picker.getImage(source: src);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
      else {
        print('لايوجد صورة ');
      }
    });
  }
  Future loadMultiImage() async {
    List<Asset>resultList = <Asset>[];
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 20,
        selectedAssets: multiImages,
        enableCamera: true,
      );
      setState(() {
        multiImages = resultList;

      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Container(
                        width: 400,
                        height: 60,
                        color: kInputFailedColor,
                        //decoration:BoxDecoration(border: Border.all(color: Colors.blueAccent), borderRadius: BorderRadius.circular(5)),
                        child: DropdownButton(
                          isExpanded: false,
                          underline: Container(height: 0, color: Colors.black,),
                          dropdownColor: kInputFailedColor,
                          hint: Text('اختر صنف المنتج'),
                          icon: Icon(Icons.arrow_drop_down),
                          style: TextStyle(color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                          onChanged: (value) {
                            setState(() {
                              _category = value;
                            });
                          },
                          items: listItems.map((valueItem) {
                            return DropdownMenuItem
                              (
                              value: valueItem,
                              child: Text(valueItem),
                            );
                          }).toList(),
                          value: _category,
                        ),
                      ),

                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Container(
                        width: 400,
                        height: 60,
                        color: kInputFailedColor,
                        //decoration:BoxDecoration(border: Border.all(color: Colors.blueAccent), borderRadius: BorderRadius.circular(5)),
                        child: DropdownButton(
                          isExpanded: false,
                          underline: Container(height: 0, color: Colors.black,),
                          dropdownColor: kInputFailedColor,
                          hint: Text('اختر الشركة'),
                          icon: Icon(Icons.arrow_drop_down),
                          style: TextStyle(color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                          onChanged: (value) {
                            setState(() {
                              brand = value;
                            });
                          },
                          items: listBrand.map((valueItem) {
                            return DropdownMenuItem
                              (
                              value: valueItem,
                              child: Text(valueItem),
                            );
                          }).toList(),
                          value: brand,
                        ),
                      ),

                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      icon: Icons.add,
                      hint: 'اسم المنتج',
                      onClick: (value) {
                        _name = value;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      icon: Icons.money,
                      hint: ' سعر المنتج',
                      onClick: (value) {
                        _price = value;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      icon: Icons.details,
                      hint: 'وصف المنتج',
                      onClick: (value) {
                        _description = value;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: GestureDetector(
                        onTap: () {
                          var ad = AlertDialog(
                            title: Text('اختر الصورة من  '),
                            content: Container(
                              height: 150,
                              child: Column(
                                children: [
                                  Divider(color: Colors.black),
                                  Container(
                                    color: Colors.teal,
                                    child: ListTile(
                                      leading: Icon(Icons.image),
                                      title: Text('معرض الصور'),
                                      onTap: () {
                                        getImage(ImageSource.gallery);
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    color: Colors.teal,
                                    child: ListTile(
                                      leading: Icon(Icons.image),
                                      title: Text('الكاميرا'),
                                      onTap: () {
                                        getImage(ImageSource.camera);
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                          showDialog(
                              context: context, builder: (context) => ad);
                        },
                        child: Container(
                          color: _image == null ? Colors.blueGrey : Colors
                              .white,
                          height: MediaQuery.of(context).size.height * .25,
                          width: MediaQuery.of(context).size.width * .84,
                          child: _image == null ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'انقر لإضافة صورة',
                                style: TextStyle(
                                    fontWeight: FontWeight.w100,
                                    fontSize: 16,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                              Icon(Icons.add_a_photo),
                            ],
                          )
                              : Image.file(_image),
                        ),
                      ),
                    ),
                    // اضافة المزيد من الصور
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: GestureDetector(
                        onTap: () {
                          loadMultiImage();
                        },
                        child: Container(
                          color: multiImages.isEmpty == true ? Colors.blueGrey : Colors.white,
                          height: MediaQuery.of(context).size.height * .25,
                          width: MediaQuery.of(context).size.width * .84,
                          child: multiImages.isEmpty == true ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'انقر لإضافة المزيد من الصور',
                                style: TextStyle(
                                    fontWeight: FontWeight.w100,
                                    fontSize: 16, color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                              Icon(Icons.add_a_photo),
                            ],
                          )
                              : GridView.count(
                              crossAxisCount: 3,
                              children:
                              List.generate(multiImages.length, (index) {
                                return AssetThumb(
                                    asset: multiImages[index],
                                    width: 100,
                                    height: 100
                                );
                              })

                          ),
                        ),
                      ),
                    ),
                    ////////////  زر اضافة صورة
                    ButtonTheme(
                      buttonColor: kInputFailedColor,
                      minWidth: MediaQuery
                          .of(context)
                          .size
                          .width * .84,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * .07,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          )),
                      child: ElevatedButton(
                        onPressed: () {
                          // if (_globalKey.currentState.validate()) {
                          _globalKey.currentState.save();
                          uploadFile1();
                          _store.addPoduct(Product(
                              pName: _name,
                              pPrice: _price,
                              pDescription: _description,
                              pImg: url,
                              pCategory: _category,
                              brand: brand
                          ));

                        }

                        //},
                        ,
                        child: Text('إضافة المنتج', style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ],
                ),
              ]),
        ));
  }


  Future uploadFile1() async {
    try {
      if (_image == null) return;
      final fileName = basename(_image.path);
      final destination = 'files/$fileName';
      var ref = FirebaseStorage.instance.ref(destination);
      await ref.putFile(_image);
      url = await ref.getDownloadURL();
    }on FirebaseStorage catch(e){
      print(e);
    }

  }

  Future uploadFileMulti() async{
    if (multiImages.isEmpty == true) return;
    try {
      int i=0;
      for (var img in multiImages) {
        final _reference = FirebaseStorage.instance.ref().child(
            'filesMulti/${basename(img.identifier)}');
        await _reference.putFile(__image[i]);
        _reference.getDownloadURL();
      }
    }catch(e) {}

  }

}

