import 'package:flutter/material.dart';
import 'package:zona0_apk/domain/entities/category.dart';
import 'package:zona0_apk/domain/entities/product.dart';

import 'promo.dart';

class AppData {
  static List<Product> allProducts = [
    Product(
      id: 1,
      name: 'Laptop Alienware',
      brand: 'Dell',
      price: 345.00,
      discount: 10,
      image: 'assets/imagen/1.png',
      category: 1,
      cantMax: 1
    ),
    Product(
      id: 2,
      name: 'Google Pixel 5',
      brand: 'Google',
      price: 280.00,
      discount: 0,
      image: 'assets/imagen/2.png',
      category: 2,
      cantInCart: 1,
      cantMax: 3
    ),
    Product(
      id: 3,
      name: 'Enguatada Black Matter',
      brand: 'Nike',
      price: 20.00,
      discount: 5,
      image: 'assets/imagen/3.png',
      category: 3,
      cantInCart: 2,
      cantMax: 6
    ),
    Product(
      id: 4,
      name: 'Mochila Negra',
      brand: 'Thaba Cuba',
      price: 28.00,
      discount: 0,
      image: 'assets/imagen/4.png',
      category: 5,
      cantInCart: 1,
      cantMax: 4
    ),
    Product(
      id: 5,
      name: 'Laptop ASUS',
      brand: 'ASUS',
      price: 260.00,
      discount: 15,
      image: 'assets/imagen/5.png',
      category: 1,
      cantMax: 2
    ),
    Product(
      id: 6,
      name: 'Cámara 8X',
      brand: 'Sony',
      price: 65.00,
      discount: 5,
      image: 'assets/imagen/6.png',
      category: 4,
      cantInCart: 3,
      cantMax: 3
    ),
    Product(
      id: 7,
      name: 'Mochila Marrón',
      brand: 'eXtreme',
      price: 15.00,
      discount: 0,
      image: 'assets/imagen/7.png',
      category: 5,
      cantMax: 7
    ),
    Product(
      id: 8,
      name: 'Iphone XIII',
      brand: 'Apple',
      price: 720.00,
      discount: 15,
      image: 'assets/imagen/8.png',
      category: 2,
      cantMax: 2
    ),
    Product(
      id: 9,
      name: 'Abrigo de lana negro',
      brand: 'Adidas',
      price: 32.00,
      discount: 3,
      image: 'assets/imagen/9.png',
      category: 3,
      cantMax: 12
    ),
    Product(
      id: 10,
      name: 'Laptop Dell',
      brand: 'Dell',
      price: 180.00,
      discount: 0,
      image: 'assets/imagen/10.png',
      category: 1,
      cantInCart: 1,
      cantMax: 2
    ),
    Product(
      id: 11,
      name: 'Cámara UltraZoom',
      brand: 'Sony',
      price: 45.00,
      discount: 0,
      image: 'assets/imagen/11.png',
      category: 4,
      cantMax: 5
    ),
    Product(
      id: 12,
      name: 'Joystick para XBOX',
      brand: 'Microsoft Xbox',
      price: 175.00,
      discount: 15,
      image: 'assets/imagen/12.png',
      category: 6,
      cantInCart: 2,
      cantMax: 6
    ),
    Product(
      id: 13,
      name: 'Google Pixel 6',
      brand: 'Google',
      price: 355.00,
      discount: 0,
      image: 'assets/imagen/13.png',
      category: 2,
      cantInCart: 1,
      cantMax: 1
    ),
  ];

  static List<Category> categoryList = [
    // Category(),
    Category(
        id: 1,
        name: "Laptops",
        image: 'assets/imagen/1.png',
        isSelected: true),
    Category(id: 2, name: "Teléfonos", image: 'assets/imagen/8.png'),
    Category(id: 3, name: "Ropa", image: 'assets/imagen/3.png'),
    Category(id: 4, name: "Cámaras", image: 'assets/imagen/6.png'),
    Category(id: 5, name: "Mochilas", image: 'assets/imagen/4.png'),
    Category(id: 6, name: "Mandos", image: 'assets/imagen/12.png'),
  ];
  static List<String> showThumbnailList = [
    "assets/imagen/10.png",
    "assets/imagen/11.png",
    "assets/imagen/12.png",
    "assets/imagen/13.png",
  ];

  static List<Promo> allPromos = [
    Promo(
      image: "assets/imagen/b1.jpg",
    ),
    Promo(
      image: "assets/imagen/b2.jpg",
    ),
    Promo(
      image: "assets/imagen/b3.jpg",
    ),
    Promo(
      image: "assets/imagen/b4.jpg",
    ),
  ];

  static String description =
      "Clean lines, versatile and timeless—the people shoe returns with the Nike Air Max 90. Featuring the same iconic Waffle sole, stitched overlays and classic TPU accents you come to love, it lets you walk among the pantheon of Air. ßNothing as fly, nothing as comfortable, nothing as proven. The Nike Air Max 90 stays true to its OG running roots with the iconic Waffle sole, stitched overlays and classic TPU details. Classic colours celebrate your fresh look while Max Air cushioning adds comfort to the journey.";
}
