// To parse this JSON data, do
//
//     final consumeHomePageJsonModel = consumeHomePageJsonModelFromJson(jsonString);

import 'dart:convert';

ConsumeHomePageJsonModel consumeHomePageJsonModelFromJson(String str) =>
    ConsumeHomePageJsonModel.fromJson(json.decode(str));

class ConsumeHomePageJsonModel {
  List<Widgets> widgets;

  ConsumeHomePageJsonModel({
    required this.widgets,
  });

  factory ConsumeHomePageJsonModel.fromJson(Map<String, dynamic> json) =>
      ConsumeHomePageJsonModel(
        widgets:
            List<Widgets>.from(json["widgets"].map((x) => Widgets.fromJson(x))),
      );
}

class Widgets {
  String type;
  String? image;
  String? headerText;
  String? hexaDecimalColorCode;
  double? padding;
  double? borderRadius;
  String? footerText;
  bool? footerIcon;
  String? title;
  List<Item>? items;

  Widgets({
    required this.type,
    this.image,
    this.headerText,
    this.hexaDecimalColorCode,
    this.padding,
    this.borderRadius,
    this.footerText,
    this.footerIcon,
    this.title,
    this.items,
  });

  factory Widgets.fromJson(Map<String, dynamic> json) => Widgets(
        type: json["type"],
        image: json["image"],
        headerText: json["header_text"],
        hexaDecimalColorCode: json["hexaDecimal_colorCode"],
        padding: json["padding"],
        borderRadius: json["border_radius"],
        footerText: json["footer_text"],
        footerIcon: json["footer_icon"],
        title: json["title"],
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      );
}

class Item {
  String type;
  String text;
  String image;

  Item({
    required this.type,
    required this.text,
    required this.image,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        type: json["type"],
        text: json["text"],
        image: json["image"],
      );
}
