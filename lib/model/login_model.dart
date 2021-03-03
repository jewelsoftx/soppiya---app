// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.token,
    this.businessData,
    this.webThemeData,
  });

  String token;
  BusinessData businessData;
  WebThemeData webThemeData;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    token: json["token"],
    businessData: BusinessData.fromJson(json["businessData"]),
    webThemeData: WebThemeData.fromJson(json["webThemeData"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "businessData": businessData.toJson(),
    "webThemeData": webThemeData.toJson(),
  };
}

class BusinessData {
  BusinessData({
    this.status,
    this.activePackage,
    this.id,
    this.email,
    this.packageExpiresOn,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String status;
  String activePackage;
  String id;
  String email;
  dynamic packageExpiresOn;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory BusinessData.fromJson(Map<String, dynamic> json) => BusinessData(
    status: json["status"],
    activePackage: json["activePackage"],
    id: json["_id"],
    email: json["email"],
    packageExpiresOn: json["packageExpiresOn"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "activePackage": activePackage,
    "_id": id,
    "email": email,
    "packageExpiresOn": packageExpiresOn,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}

class WebThemeData {
  WebThemeData({
    this.themeSettings,
    this.widgets,
    this.plugins,
    this.themes,
    this.backEndModules,
    this.id,
    this.businessId,
    this.v,
  });

  ThemeSettings themeSettings;
  Widgets widgets;
  List<dynamic> plugins;
  List<dynamic> themes;
  List<String> backEndModules;
  String id;
  String businessId;
  int v;

  factory WebThemeData.fromJson(Map<String, dynamic> json) => WebThemeData(
    themeSettings: ThemeSettings.fromJson(json["themeSettings"]),
    widgets: Widgets.fromJson(json["widgets"]),
    plugins: List<dynamic>.from(json["plugins"].map((x) => x)),
    themes: List<dynamic>.from(json["themes"].map((x) => x)),
    backEndModules: List<String>.from(json["backEndModules"].map((x) => x)),
    id: json["_id"],
    businessId: json["businessId"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "themeSettings": themeSettings.toJson(),
    "widgets": widgets.toJson(),
    "plugins": List<dynamic>.from(plugins.map((x) => x)),
    "themes": List<dynamic>.from(themes.map((x) => x)),
    "backEndModules": List<dynamic>.from(backEndModules.map((x) => x)),
    "_id": id,
    "businessId": businessId,
    "__v": v,
  };
}

class ThemeSettings {
  ThemeSettings({
    this.primaryColor,
    this.lightPrimaryColor,
    this.secondaryColor,
    this.textColor,
    this.highlightedTextColor,
    this.fontFamily,
  });

  String primaryColor;
  String lightPrimaryColor;
  String secondaryColor;
  String textColor;
  String highlightedTextColor;
  String fontFamily;

  factory ThemeSettings.fromJson(Map<String, dynamic> json) => ThemeSettings(
    primaryColor: json["primaryColor"],
    lightPrimaryColor: json["lightPrimaryColor"],
    secondaryColor: json["secondaryColor"],
    textColor: json["textColor"],
    highlightedTextColor: json["highlightedTextColor"],
    fontFamily: json["fontFamily"],
  );

  Map<String, dynamic> toJson() => {
    "primaryColor": primaryColor,
    "lightPrimaryColor": lightPrimaryColor,
    "secondaryColor": secondaryColor,
    "textColor": textColor,
    "highlightedTextColor": highlightedTextColor,
    "fontFamily": fontFamily,
  };
}

class Widgets {
  Widgets({
    this.header,
    this.home,
    this.category,
    this.item,
    this.footer,
    this.info,
  });

  List<Category> header;
  List<Category> home;
  List<Category> category;
  List<Category> item;
  List<Category> footer;
  List<dynamic> info;

  factory Widgets.fromJson(Map<String, dynamic> json) => Widgets(
    header: List<Category>.from(json["header"].map((x) => Category.fromJson(x))),
    home: List<Category>.from(json["home"].map((x) => Category.fromJson(x))),
    category: List<Category>.from(json["category"].map((x) => Category.fromJson(x))),
    item: List<Category>.from(json["item"].map((x) => Category.fromJson(x))),
    footer: List<Category>.from(json["footer"].map((x) => Category.fromJson(x))),
    info: List<dynamic>.from(json["info"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "header": List<dynamic>.from(header.map((x) => x.toJson())),
    "home": List<dynamic>.from(home.map((x) => x.toJson())),
    "category": List<dynamic>.from(category.map((x) => x.toJson())),
    "item": List<dynamic>.from(item.map((x) => x.toJson())),
    "footer": List<dynamic>.from(footer.map((x) => x.toJson())),
    "info": List<dynamic>.from(info.map((x) => x)),
  };
}

class Category {
  Category({
    this.id,
    this.widgetId,
    this.json,
    this.index,
    this.status,
    this.name,
  });

  String id;
  String widgetId;
  String json;
  int index;
  bool status;
  String name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["_id"],
    widgetId: json["widgetId"],
    json: json["json"],
    index: json["index"],
    status: json["status"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "widgetId": widgetId,
    "json": json,
    "index": index,
    "status": status,
    "name": name,
  };
}
