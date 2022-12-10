import 'dart:convert';

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class FuelType extends ParseObject implements ParseCloneable {
  FuelType() : super(keyTableName);
  FuelType.clone() : this();

  /// Looks strangely hacky but due to Flutter not using reflection, we have to
  /// mimic a clone
  @override
  clone(Map<String, dynamic> map) => FuelType.clone()..fromJson(map);

  static const String keyTableName = 'FuelType';

  String? get name => get<String?>('name');
  set name(String? value) => set<String?>('name', value);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'objectId': objectId,
      'name': name,
    };
  }

  factory FuelType.fromMap(Map<String, dynamic> map) {
    return FuelType()
      ..objectId = map['objectId']
      ..name = map['name'] != null ? map['name'] as String : null;
  }

  String to_json() => json.encode(toMap());

  factory FuelType.fromJson(String source) =>
      FuelType.fromMap(json.decode(source) as Map<String, dynamic>);
}
