import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:global_market/constants.dart';
import 'package:global_market/main.dart';
import 'package:global_market/models/brand.dart';
import 'package:global_market/models/category.dart';
import 'package:global_market/screens/admin/manageProduct.dart';
import 'package:global_market/screens/home1.dart';
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
class AddProduct1 extends StatefulWidget {
  static String id = 'AddProduct1';

  @override
  _AddProduct1State createState() => _AddProduct1State();
}

class _AddProduct1State extends State<AddProduct1> {
  var url;
  String _name, _price, _description, _img;
  String _category;
  String brand;
  File _image;
  List itm = [];
  final picker = ImagePicker();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _store = Store();
  List<File> __image = <File>[];
  List<Asset> multiImages = <Asset>[];
  var ref;
  List<String> listItemsCategory = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.Add_Product_Screen.tr(),style: TextStyle(color: Colors.black),),
        iconTheme: IconThemeData(color: Colors.black),

      ),

        body: StreamBuilder<QuerySnapshot>(
            stream: _category == null ? _store.loadCategories() : _store.loadBrandCategories(_category),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Brand> _brand = [];
                List<CategoryModel> _categoryModel = [];
                List<String> listItemsBrand = [];
                try {
                  if (_category == null) {
                    int i = 0;
                    for (var doc in snapshot.data.docs) {
                      _categoryModel.add(CategoryModel(
                        cateName: doc[kCateName],
                      ));
                      listItemsCategory.add(_categoryModel[i].cateName);
                      i++;
                    }
                  }
                  else {
                    int i = 0;
                    for (var doc in snapshot.data.docs) {
                      _brand.add(Brand(
                        brandName: doc[kBrandName],
                        brandImg: doc[kBrandImg],
                        categoryId: doc[kCategoryId],
                      ));
                      listItemsBrand.add(_brand[i].brandName);
                      // if (i == 0) {
                      //   listItemsCategory.add(_brand[i].categoryId);
                      // } else if (i > 0) {
                      //   if (_brand[i].categoryId != listItemsCategory[i - 1])
                      //     listItemsCategory.add(_brand[i].categoryId);
                      // }
                      i++;
                    }
                  }
                  print('All categories : $listItemsCategory');
                  print('Selected categories : [ $_category ]');
                  print('Brand of selected categories :$listItemsBrand');
                  print('Selected brand :$brand');
                } catch (e) {
                  print(e);
                }
                return Scaffold(
                    backgroundColor: Colors.white,
                    body: Form(
                      key: _globalKey,
                      child: ListView(children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .05,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(30, 0, 30, 0),
                              child: Container(

                                width: 400,
                                height: 60,
                                decoration:BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(20)),
                                child: new DropdownButton(
                                  isExpanded: true,
                                  underline: Container(
                                    height: 0,
                                    color: Colors.black,
                                  ),
                                  hint: Text(LocaleKeys.Category_Name.tr()),
                                  icon: Icon(Icons.arrow_drop_down),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                  onChanged: (value) {
                                    setState(() {
                                      _category = value;
                                      brand=null;
                                    });
                                  },
                                  items: listItemsCategory.map((valueItem) {
                                    return new DropdownMenuItem(
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
                              padding:
                                  const EdgeInsets.fromLTRB(30, 0, 30, 0),
                              child: Container(
                                width: 400,
                                height: 60,
                                decoration:BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(20)),
                                child: new DropdownButton(
                                  underline: Container(
                                    height: 0,
                                    color: Colors.black,
                                  ),
                                  isExpanded: true,
                                  hint: Text(LocaleKeys.Brand_name.tr()),
                                  icon: Icon(Icons.arrow_drop_down),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                  onChanged: (value) {
                                    setState(() {
                                      brand = value;
                                    });
                                  },
                                  items: listItemsBrand.map((valueItem) {
                                    return new DropdownMenuItem(
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
                              keyType: TextInputType.name,

                              icon: Icons.add,
                              hint: LocaleKeys.Product_name.tr(),
                              onClick: (value) {
                                _name = value;
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              keyType: TextInputType.number,

                              icon: Icons.money,
                              hint: LocaleKeys.Product_price.tr(),
                              onClick: (value) {
                                _price = value;
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomTextField(

                              keyType: TextInputType.multiline,
                              icon: Icons.details,
                              hint: LocaleKeys.Product_description.tr(),
                              onClick: (value) {
                                _description = value;
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              value: 'images/product_Image/Computers/Toshiba/3.jfif',
                              icon: Icons.picture_in_picture_sharp,
                              hint: LocaleKeys.Product_image.tr(),
                              onClick: (value) {
                                _img = value;
                              },
                            ),
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            //   child: GestureDetector(
                            //     onTap: () {
                            //       var ad = AlertDialog(
                            //         title: Text(LocaleKeys.Choose_an_image.tr()),
                            //         content: Container(
                            //           height: 150,
                            //           child: Column(
                            //             children: [
                            //               Divider(color: Colors.black),
                            //               Container(
                            //                 color: Colors.teal,
                            //                 child: ListTile(
                            //                   leading: Icon(Icons.image),
                            //                   title: Text(LocaleKeys.Product_image.tr()),
                            //                   onTap: () {
                            //                     getImage(ImageSource.gallery);
                            //                     Navigator.pop(context);
                            //                   },
                            //                 ),
                            //               ),
                            //               SizedBox(height: 10),
                            //               Container(
                            //                 color: Colors.teal,
                            //                 child: ListTile(
                            //                   leading: Icon(Icons.image),
                            //                   title: Text(LocaleKeys.Camera.tr()),
                            //                   onTap: () {
                            //                     getImage(ImageSource.camera);
                            //                     Navigator.pop(context);
                            //                   },
                            //                 ),
                            //               ),
                            //             ],
                            //           ),
                            //         ),
                            //       );
                            //       showDialog(
                            //           context: context,
                            //           builder: (context) => ad);
                            //     },
                            //     child: Container(
                            //       // color: _img == null ? Colors.blueGrey : Colors.white,
                            //       height: MediaQuery.of(context).size.height * .25,
                            //       width: MediaQuery.of(context).size.width * .84,
                            //       child: _img == null
                            //           ? Column(
                            //               mainAxisAlignment:
                            //                   MainAxisAlignment.center,
                            //               children: <Widget>[
                            //                 Text(
                            //                   LocaleKeys.Choose_an_image.tr(),
                            //                   style: TextStyle(
                            //                       fontWeight: FontWeight.w100,
                            //                       fontSize: 16,
                            //                       color: Colors.white),
                            //                   textAlign: TextAlign.center,
                            //                 ),
                            //                 Icon(Icons.add_a_photo),
                            //               ],
                            //             )
                            //           : Image.asset(_img),
                            //     ),
                            //   ),
                            // ),
                           // اضافة المزيد من الصور
                           //  Padding(
                           //    padding:
                           //        const EdgeInsets.fromLTRB(10, 10, 10, 10),
                           //    child: GestureDetector(
                           //      onTap: () {
                           //        loadMultiImage();
                           //      },
                           //      child: Container(
                           //        color: multiImages.isEmpty == true
                           //            ? Colors.blueGrey
                           //            : Colors.white,
                           //        height: MediaQuery.of(context).size.height *
                           //            .25,
                           //        width:
                           //            MediaQuery.of(context).size.width * .84,
                           //        child: multiImages.isEmpty == true
                           //            ? Column(
                           //                mainAxisAlignment:
                           //                    MainAxisAlignment.center,
                           //                children: <Widget>[
                           //                  Text(
                           //                    'انقر لإضافة المزيد من الصور',
                           //                    style: TextStyle(
                           //                        fontWeight: FontWeight.w100,
                           //                        fontSize: 16,
                           //                        color: Colors.black),
                           //                    textAlign: TextAlign.center,
                           //                  ),
                           //                  Icon(Icons.add_a_photo),
                           //                ],
                           //              )
                           //            : GridView.count(
                           //                crossAxisCount: 3,
                           //                children: List.generate(
                           //                    multiImages.length, (index) {
                           //                  return AssetThumb(
                           //                      asset: multiImages[index],
                           //                      width: 100,
                           //                      height: 100);
                           //                })),
                           //      ),
                           //    ),
                           //  ),
                            ////////  زر اضافة صورة
                            SizedBox(
                              height: 10,
                            ),
                            ButtonTheme(
                              minWidth:
                                  MediaQuery.of(context).size.width * .84,
                              height:
                                  MediaQuery.of(context).size.height * .07,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              )),
                              child: MaterialButton(
                                color: Home1.changColor(),
                                // style: ButtonStyle(backgroundColor: MaterialStateProperty.all(kColor)),
                                onPressed: () {
                                   if (_globalKey.currentState.validate()) {
                                  _globalKey.currentState.save();
                                  if(brand==null||_category==null ){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(LocaleKeys.Field_is_empty.tr())));
                                  }
                                  else{
                                  showWarningAdd(context);

                                  _category=null;

                                  brand=null;

                                  print(url);
                                }}
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    height: 60,
                                    width: MediaQuery.of(context).size.width*.75,
                                    child: Text(LocaleKeys.Add_Product.tr(),style: TextStyle(fontWeight:FontWeight.bold,fontSize:18,color: Colors.black))),
                              ),
                            ),
                          ],
                        ),
                      ]),
                    ));
              } else {
                return Center(child: Text(LocaleKeys.Loading.tr()));
              }
            }));
  }
  getImage(ImageSource src) async {
    final pickedFile = await picker.pickImage(source: src);
    setState(() {
      _image = File(pickedFile.path);
    });
    if (pickedFile.path == null) {
      retrieveLostData();
    } else {
      print('image chosen$pickedFile.path');
    }
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image = File(response.file.path);
      });
    } else {
      print(response.file);
    }
  }

  Future loadMultiImage() async {
    List<Asset> resultList = <Asset>[];
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

  Future uploadFile1() async {
    try {
      if (_image == null) return;
      final fileName = basename(_image.path);
      final destination = 'files/$fileName';
      print(destination);
      ref = FirebaseStorage.instance.ref().child(destination);
      await ref.putFile(_image).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          url = value;
        });
      });
      print('url: $url');
    } on FirebaseStorage catch (e) {
      print(e);
    }
  }
  Future uploadFileMulti() async {
    if (multiImages.isEmpty == true) return;
    try {
      int i = 0;
      for (var img in multiImages) {
        final _reference = FirebaseStorage.instance
            .ref()
            .child('filesMulti/${basename(img.identifier)}');
        await _reference.putFile(__image[i]);
        _reference.getDownloadURL();
      }
    } catch (e) {}
  }
  void showWarningAdd(context) async {
    Container alertDialog = Container(
      child: AlertDialog(
        actions: <Widget>[
          MaterialButton(
            color: MyApp.tm==ThemeMode.light?kColor:Colors.grey,

            onPressed: ()
            {
              uploadFile1();
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(LocaleKeys.Adding_is_done.tr())));
              _store.addPoduct(Product(
                  pName: _name,
                  pPrice: _price,
                  pDescription: _description,
                  pImg: _img,
                  pCategory: _category,
                  brand: brand
              ));
              _store.addPoduct2(_category, brand, Product(
                pName: _name,
                pPrice: _price,
                pDescription: _description,
                pImg: _img,
                pCategory: _category,
              ));
              Navigator.pop(context);
              Navigator.pushNamed(context, ManageProduct.id);
            },

            child: Text(LocaleKeys.Yes.tr(),
            ),
          ),
          MaterialButton(
            color: MyApp.tm==ThemeMode.light?kColor:Colors.grey,
            onPressed: ()
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
            LocaleKeys.Do_you_want_to_add.tr(),
            style: TextStyle(color: Colors.black87, fontSize: 16),
          ),
        ),
        title: Row(
          children: [
            Text(LocaleKeys.Warning_Adding.tr()),
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
  }


// void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//   super.debugFillProperties(properties);
//   properties.add(DiagnosticsProperty<StreamBuilder<QuerySnapshot<Object>>>('ca', ca));
//   properties.add(DiagnosticsProperty<StreamBuilder<QuerySnapshot<Object>>>('ca', ca));
// }

  // getCategory() {
  //   return StreamBuilder<QuerySnapshot>(
  //       stream: _store.loadCategories(),
  //       builder: (context, snapshot) {
  //         if (snapshot.hasData) {
  //           List<CategoryModel> _categoryModel = [];
  //           List<String> listItems = [];
  //           int i = 0;
  //           for (var doc in snapshot.data.docs) {
  //             _categoryModel.add(CategoryModel(
  //                 cateName: doc[kCateName], cateImg: doc[kCateImg]));
  //             itm.add(_categoryModel[i].cateName);
  //
  //             i++;
  //           }
  //           itm.add(listItems);
  //           print('itemkkkkk$itm');
  //           return null;
  //         } else {
  //           return null;
  //         }
  //       });
  // }
}
