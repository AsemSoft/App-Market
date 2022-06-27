class CategoryModel{
  String cateName,cateImg,cateId;

  CategoryModel({
    this.cateName,
    this.cateImg,
    this.cateId
  });
  // CategoryModel.fromJson(Map<dynamic, dynamic> map) {
  //   if (map == null) {
  //     return;
  //   }
  //   cateName = map['name'];
  //   cateImg = map['image'];
  // }
  //
  // toJson() {
  //   return {
  //     'name': cateName,
  //     'image': cateImg,
  //   };
  // }
}