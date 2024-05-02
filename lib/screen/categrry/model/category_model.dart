class categoryModel
{
  int?id;
  String?name;

  categoryModel({this.id, this.name});

  factory categoryModel.mapToModel(Map m1)
  {
    return categoryModel(id:m1['id'],name:m1['name']);
}
}