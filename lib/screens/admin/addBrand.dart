import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_market/constants.dart';
import 'package:global_market/models/brand.dart';
import 'package:global_market/models/category.dart';
import 'package:global_market/screens/admin/adminHome.dart';
import 'package:global_market/services/store.dart';
import 'package:global_market/translations/locale_keys.g.dart';
import 'package:global_market/widgets/CustomTextField.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:easy_localization/easy_localization.dart';

class AddBrand extends StatefulWidget {
  static String id = 'AddBrand';

  @override
  _AddBrandState createState() => _AddBrandState();
}

class _AddBrandState extends State<AddBrand> {

  // getCategory(){
  //   _store.loadCategories().any((value) {
  //
  //     for (int i = 0; i < value.length; i++) {
  //       _categoryModel.add(CategoryModel.fromJson(value[i].data()));
  //       listItems = _categoryModel[i].cateName.toString() as List;
  //   }
  //   });}

  var url;
  String _name,_category;
  File _image;
  final picker = ImagePicker();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _store = Store();
  getImage(ImageSource src) async {
    final pickedFile = await picker.pickImage(source: src);
    setState(() {
      _image = File(pickedFile.path);

    });
    if (pickedFile.path == null) {
      retrieveLostData();
    }
    else {
      print('image chosen$_image');
    }
  }
  Future<void> retrieveLostData() async {
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image=File(response.file.path);
      });
    } else {
      print(response.file);
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: _store.loadCategories(),
          builder: (context, snapshot)
          {
            if(snapshot.hasData) {
              List<CategoryModel>_categoryModel=[];
              List<String> listItems =[];
              int i=0;
              for (var doc in snapshot.data.docs)
              {
                _categoryModel.add(CategoryModel(
                  cateName: doc[kCateName],
                  cateImg: doc[kCateImg],
                ));
                listItems.add(_categoryModel[i].cateName);
                i++;
              }
              print(listItems);

              // if(_categoryModel.length!=0){
              // for(int i=0;i<_categoryModel.length;i++) {
              //   listItems.add(_categoryModel[i].cateName);
              //   //listItems.insert(i,_categoryModel[i].cateName.toString());
              // }}
              return Scaffold(
                  backgroundColor: Colors.white,
                  body: Form(
                    key: _globalKey,
                    child: ListView(
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * .05,
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
                                    // isExpanded: false,
                                    underline: Container(height: 0, color: Colors.black,),
                                    dropdownColor: kInputFailedColor,
                                    hint: Text(LocaleKeys.Category_Name.tr()),
                                    icon: Icon(Icons.arrow_drop_down),
                                    style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
                                    items: listItems.map((valueItem) {
                                      return DropdownMenuItem
                                        (
                                        value: valueItem,
                                        child: Text(valueItem),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _category = value;
                                      });
                                    },
                                    value: _category,
                                  ),
                                ),

                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomTextField(
                                value: '',
                                icon: Icons.add,
                                hint: LocaleKeys.Brand_name.tr(),
                                onClick: (value) {
                                  _name = value;
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    10, 10, 10, 10),
                                child: GestureDetector(
                                  onTap: () {
                                    var ad = AlertDialog(
                                      title: Text(LocaleKeys.Choose_an_image.tr()),
                                      content: Container(
                                        height: 150,
                                        child: Column(
                                          children: [
                                            Divider(color: Colors.black),
                                            Container(
                                              color: Colors.teal,
                                              child: ListTile(
                                                leading: Icon(Icons.image),
                                                title: Text(LocaleKeys.Brand_image.tr()),
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
                                                title: Text(LocaleKeys.Camera.tr()),
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
                                        context: context,
                                        builder: (context) => ad);
                                  },
                                  child: Container(
                                    color: _image == null
                                        ? Colors.blueGrey
                                        : Colors
                                        .white,
                                    height: MediaQuery
                                        .of(context)
                                        .size
                                        .height * .25,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width * .84,
                                    child: _image == null ? Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          LocaleKeys.Choose_an_image.tr(),
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
                              SizedBox(
                                height: 10,
                              ),
                              ////////////   زر اضافة صورة
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
                                    _store.addBrand(_category, Brand(
                                      brandName: _name,
                                      categoryId: _category,
                                      brandImg: url,
                                    ));
                                    print(url);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(LocaleKeys.Adding_is_done.tr())));
                                    Navigator.pop(context);
                                    Navigator.pushNamed(context, AdminHome.id);
                                  }

                                  //},
                                  ,
                                  child: Text(LocaleKeys.Brand_name.tr(), style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),),
                                ),
                              ),
                            ],
                          ),
                        ]),
                  ));
            }
            else {
              return Center(child: Text(LocaleKeys.Location.tr()));
            }
          },
      ),
    );
  }

  var ref;
  Future uploadFile1() async {
    try {
      if (_image == null) return;
      final fileName = basename(_image.path);
      final destination = 'files/$fileName';
      print(destination);
      ref =  FirebaseStorage.instance.ref().child(destination);
      await ref.putFile(_image).whenComplete(() async{
        await ref.getDownloadURL().then((value){
          url=value;
        });

      });
      print('url: $url');
    }on FirebaseStorage catch(e){
      print(e);
    }

  }

}