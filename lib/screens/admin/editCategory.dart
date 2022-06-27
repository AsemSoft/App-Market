import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_market/constants.dart';
import 'package:global_market/screens/admin/adminHome.dart';
import 'package:global_market/services/store.dart';
import 'package:global_market/translations/locale_keys.g.dart';
import 'package:global_market/widgets/CustomTextField.dart';
import 'package:image_picker/image_picker.dart';
import 'package:global_market/models/category.dart';
import 'package:path/path.dart';
import 'package:easy_localization/easy_localization.dart';

class EditCategory extends StatefulWidget {
  static String id = 'EditCategory';

  @override
  _EditCategoryState createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {

  var url;
  String _name;
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
    CategoryModel _category = ModalRoute.of(context).settings.arguments;
   _image=File(_category.cateImg);
    return Scaffold(


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
                    CustomTextField(
                      icon: Icons.add,
                      value: _category.cateName,
                      hint: LocaleKeys.Category_Name.tr(),
                      onClick: (value) {
                        _name = value;
                        uploadFile1();
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
                                      title: Text(LocaleKeys.Category_image),
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
                              context: context, builder: (context) => ad);
                        },
                        child: Container(
                          color: _image == null ? Colors.blueGrey : Colors.white,
                          height: MediaQuery.of(context).size.height * .25,
                          width: MediaQuery.of(context).size.width * .84,
                          child:  Image.network(_category.cateImg),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ////////////   زر اضافة صورة
                    ButtonTheme(
                      buttonColor: kInputFailedColor,
                      minWidth: MediaQuery.of(context).size.width ,
                      height: MediaQuery.of(context).size.height * .07,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          )),
                      child: ElevatedButton(
                        onPressed: () {
                          uploadFile1();
                          // if (_globalKey.currentState.validate()) {
                          _globalKey.currentState.save();
                          print('url: $url');
                          _store.editCategory(({
                            kCateName: _name,
                            kCateImg: url.toString(),
                          }),
                            _category.cateName
                          );

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تم التعديل')));
                          Navigator.pop(context);
                          Navigator.pushNamed(context,AdminHome.id);
                          print('url: $url');
                        },

                        //},

                        child: Text(LocaleKeys.Edit.tr(), style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ],
                ),
              ]),
        ));


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