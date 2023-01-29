import 'dart:convert';

import 'package:carzoum/src/data/src/models/models.dart';
import 'package:carzoum/src/data/src/models/src/model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:equatable/equatable.dart';

class Store extends ParseObject with EquatableMixin implements ParseCloneable {
  Store() : super(keyTableName);
  Store.clone() : this();

  @override
  clone(Map<String, dynamic> map) => Store.clone()..fromJson(map);

  static const String keyTableName = 'Store';

  String? get name => get<String?>('name');
  set name(String? value) => set<String?>('name', value);

  String? get location => get<String?>('location');
  set location(String? value) => set<String?>('location', value);

  String? get profileImage => get<String?>('profileImage');
  set profileImage(String? value) => set<String?>('profileImage', value);

  String? get about => get<String?>('about');
  set about(String? value) => set<String?>('about', value);

  String? get whatsappPhone => get<String?>('whatsappPhone');
  set whatsappPhone(String? value) => set<String?>('whatsappPhone', value);

  User? get owner => get('owner');
  set owner(User? value) => set('owner', value);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'objectId': objectId,
      'name': name,
      'location': location,
      'whatsappPhone': whatsappPhone,
      'about': about,
    };
  }

  @override
  List<Object?> get props => [
        name,
        location,
        profileImage,
        whatsappPhone,
        about,
      ];

  factory Store.fromMap(Map<String, dynamic> map) {
    Store store = Store()
      ..objectId = map['objectId']
      ..name = map['name'] != null ? map['name'] as String : null
      ..location = map['location'] != null ? map['location'] as String : null
      ..about = map['about'] != null ? map['about'] as String : null
      ..whatsappPhone =
          map['whatsappPhone'] != null ? map['whatsappPhone'] as String : null;

    return store;
  }

  String to_json() => json.encode(toMap());

  factory Store.fromJson(String source) =>
      Store.fromMap(json.decode(source) as Map<String, dynamic>);
}
