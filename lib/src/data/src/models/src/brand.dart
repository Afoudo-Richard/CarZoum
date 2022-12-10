import 'dart:convert';
import 'dart:io';

import 'package:carzoum/src/data/src/models/src/model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class Brand extends ParseObject implements ParseCloneable {
  Brand() : super(keyTableName);
  Brand.clone() : this();

  @override
  clone(Map<String, dynamic> map) => Brand.clone()..fromJson(map);

  static const String keyTableName = 'Brand';

  String? get name => get<String?>('name');
  set name(String? value) => set<String?>('name', value);

  // ParseRelation<Model>? get models => getRelation<Model>('models');

  String? get logoImage => get<ParseFile?>('logo')?.url;
  set logoImage(String? value) =>
      set<ParseFile?>('logo', ParseFile(File(""), url: value));

  ParseFile? get logo => get<ParseFile?>('logo');
  set logo(ParseFile? value) => set<ParseFile?>('logo', value);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'objectId': objectId,
      'name': name,
      'logoImage': logoImage,
    };
  }

  factory Brand.fromMap(Map<String, dynamic> map) {
    return Brand()
      ..objectId = map['objectId']
      ..name = map['name'] != null ? map['name'] as String : null
      ..logoImage =
          map['logoImage'] != null ? map['logoImage'] as String : null;
  }

  String to_json() => json.encode(toMap());

  factory Brand.fromJson(String source) =>
      Brand.fromMap(json.decode(source) as Map<String, dynamic>);
}
