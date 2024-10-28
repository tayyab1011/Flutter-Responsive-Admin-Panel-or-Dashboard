// To parse this JSON data, do
//
//     final getProductModel = getProductModelFromJson(jsonString);

import 'dart:convert';

GetProductModel getProductModelFromJson(String str) => GetProductModel.fromJson(json.decode(str));

String getProductModelToJson(GetProductModel data) => json.encode(data.toJson());

class GetProductModel {
    int? code;
    String? status;
    String? message;
    List<Datum>? data;

    GetProductModel({
        this.code,
        this.status,
        this.message,
        this.data,
    });

    factory GetProductModel.fromJson(Map<String, dynamic> json) => GetProductModel(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    String? id;
    String? name;
    String? description;
    String? shortDescription;
    double? price;
    int? quantity;
    String? category;
    String? image;
    int? v;

    Datum({
        this.id,
        this.name,
        this.description,
        this.shortDescription,
        this.price,
        this.quantity,
        this.category,
        this.image,
        this.v,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        shortDescription: json["shortDescription"],
        price: json["price"]?.toDouble(),
        quantity: json["quantity"],
        category: json["category"],
        image: json["image"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "shortDescription": shortDescription,
        "price": price,
        "quantity": quantity,
        "category": category,
        "image": image,
        "__v": v,
    };
}
