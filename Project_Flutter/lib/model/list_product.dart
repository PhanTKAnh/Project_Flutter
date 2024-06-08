class ProduceModel {
  String? name;
  String? price;
  String? category;
  String? image;
  ProduceModel();
}

List catArr = [
  {"image": "assets/images/nike.png", "name": "Nike"},
  {"image": "assets/images/puma.png", "name": "Puma"},
  {"image": "assets/images/adidas.png", "name": "Adidas"},
  {"image": "assets/images/converse.png", "name": "Converse"},
];

List popularArr = [
  {
    "name": "Nike Jordan",
    "price": "\$300",
    "category": "Nike",
    "image": "assets/images/i1.png"
  },
  {
    "name": "Nike Air Max",
    "price": "\$300",
    "category": "Nike",
    "image": "assets/images/i2.png"
  },
  {
    "name": "Nike Air Jordan",
    "price": "\$300",
    "category": "Nike",
    "image": "assets/images/i3.png"
  }
];

List<ProduceModel> arrivalArr = [
  ProduceModel()
    ..name = "Nike Jordan"
    ..price = "\$300"
    ..category = 'Nike'
    ..image = "assets/images/arr1.png",
  ProduceModel()
    ..name = "Nike Jordan"
    ..price = "\$300"
    ..category = 'Nike'
    ..image = "assets/images/arr2.png",
  ProduceModel()
    ..name = "Nike Jordan"
    ..price = "\$300"
    ..category = 'Nike'
    ..image = "assets/images/arr3.png"
];
