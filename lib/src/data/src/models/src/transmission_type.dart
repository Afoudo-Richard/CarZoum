import 'dart:convert';

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class TransmissionType extends ParseObject implements ParseCloneable {
  TransmissionType() : super(keyTableName);
  TransmissionType.clone() : this();

  @override
  clone(Map<String, dynamic> map) => TransmissionType.clone()..fromJson(map);

  static const String keyTableName = 'TransmissionType';

  String? get name => get<String?>('name');
  set name(String? value) => set<String?>('name', value);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'objectId': objectId,
      'name': name,
    };
  }

  factory TransmissionType.fromMap(Map<String, dynamic> map) {
    return TransmissionType()
      ..objectId = map['objectId']
      ..name = map['name'] != null ? map['name'] as String : null;
  }

  String to_json() => json.encode(toMap());

  factory TransmissionType.fromJson(String source) =>
      TransmissionType.fromMap(json.decode(source) as Map<String, dynamic>);
}
