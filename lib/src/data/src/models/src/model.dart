import 'dart:convert';

import 'package:carzoum/src/data/src/models/src/brand.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class Model extends ParseObject implements ParseCloneable {
  Model() : super(keyTableName);
  Model.clone() : this();

  @override
  clone(Map<String, dynamic> map) => Model.clone()..fromJson(map);

  static const String keyTableName = 'Model';

  String? get name => get<String?>('name');
  set name(String? value) => set<String?>('name', value);

  Brand? get brand => get('brand');
  set brand(Brand? value) => set('brand', value);

  List<dynamic>? get yearsOfManufacture => get('years_of_manufacture');
  set yearsOfManufacture(List<dynamic>? value) =>
      set('years_of_manufacture', value);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'objectId': objectId,
      'name': name,
      'brand': brand != null ? brand!.toMap() : null,
      'yearsOfManufacture': yearsOfManufacture,
    };
  }

  factory Model.fromMap(Map<String, dynamic> map) {
    return Model()
      ..objectId = map['objectId']
      ..name = map['name'] != null ? map['name'] as String : null
      ..brand = Brand.fromMap(map['brand'] ?? <String, dynamic>{})
      ..yearsOfManufacture = map['yearsOfManufacture'] != null
          ? map['yearsOfManufacture'] as List<dynamic>
          : null;
  }

  String to_json() => json.encode(toMap());

  factory Model.fromJson(String source) =>
      Model.fromMap(json.decode(source) as Map<String, dynamic>);
}
