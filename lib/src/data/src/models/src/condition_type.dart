import 'dart:convert';

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ConditionType extends ParseObject implements ParseCloneable {
  ConditionType() : super(keyTableName);
  ConditionType.clone() : this();

  @override
  clone(Map<String, dynamic> map) => ConditionType.clone()..fromJson(map);

  static const String keyTableName = 'ConditionType';

  String? get name => get<String?>('name');
  set name(String? value) => set<String?>('name', value);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'objectId': objectId,
      'name': name,
    };
  }

  factory ConditionType.fromMap(Map<String, dynamic> map) {
    return ConditionType()
      ..objectId = map['objectId']
      ..name = map['name'] != null ? map['name'] as String : null;
  }

  String to_json() => json.encode(toMap());

  factory ConditionType.fromJson(String source) =>
      ConditionType.fromMap(json.decode(source) as Map<String, dynamic>);
}
