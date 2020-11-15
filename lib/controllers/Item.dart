import 'dart:io';
import 'dart:convert';

class Item {
  final int id;
  final String name;
  final String des;
  final int numOfPieces;
  final int price;
  final File image;

  Item(
      {this.id, this.name, this.des, this.numOfPieces, this.price, this.image});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      des: json['des'],
      numOfPieces: json['numOfPieces'],
      price: json['price'],
      image: json['image'],
    );
  }
}
