// To parse this JSON data, do
//
//     final addProductModel = addProductModelFromJson(jsonString);

import 'dart:convert';

AddProductModel addProductModelFromJson(String str) => AddProductModel.fromJson(json.decode(str));

String addProductModelToJson(AddProductModel data) => json.encode(data.toJson());

class AddProductModel {
    int? code;
    String? status;
    String? message;
    Data? data;

    AddProductModel({
        this.code,
        this.status,
        this.message,
        this.data,
    });

    factory AddProductModel.fromJson(Map<String, dynamic> json) => AddProductModel(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    String? name;
    String? description;
    String? shortDescription;
    double? price;
    int? quantity;
    String? category;
    String? image;
    String? id;
    int? v;

    Data({
        this.name,
        this.description,
        this.shortDescription,
        this.price,
        this.quantity,
        this.category,
        this.image,
        this.id,
        this.v,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        description: json["description"],
        shortDescription: json["shortDescription"],
        price: json["price"]?.toDouble(),
        quantity: json["quantity"],
        category: json["category"],
        image: json["image"],
        id: json["_id"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "shortDescription": shortDescription,
        "price": price,
        "quantity": quantity,
        "category": category,
        "image": image,
        "_id": id,
        "__v": v,
    };
}
