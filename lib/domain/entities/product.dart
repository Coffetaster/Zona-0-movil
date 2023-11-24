class Product {
  int id;
  String name;
  String brand;
  String description;
  int category;
  String image;
  double price;
  double discount;
  bool isSelected;
  int cantInCart;
  int cantMax;
  Product({
    required this.id,
    required this.name,
    required this.brand,
    this.description = "Nisi ad pariatur cupidatat eiusmod aliquip mollit aliqua veniam exercitation Lorem est est enim. Et amet excepteur occaecat quis ex ex nostrud voluptate dolor anim ea veniam sint nulla. Esse aliqua reprehenderit consectetur consequat sit nostrud anim mollit id fugiat occaecat nisi. Dolor esse ex aliqua ad nostrud ex consectetur nostrud. Eiusmod sit qui in laboris tempor proident est nisi nulla eiusmod anim quis sit. Ipsum do est sit commodo velit commodo aliquip. Et nostrud exercitation cillum adipisicing ea do tempor deserunt sint.",
    required this.category,
    required this.image,
    required this.price,
    this.discount = 0,
    this.isSelected = false,
    this.cantInCart = 0,
    this.cantMax = 10,
  });

  double get realPrice => (price - (price * discount / 100));
}
