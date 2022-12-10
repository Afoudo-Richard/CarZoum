import 'package:carzoum/src/data/src/models/models.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class Vehicle extends ParseObject implements ParseCloneable {
  Vehicle() : super(keyTableName);
  Vehicle.clone() : this();

  /// Looks strangely hacky but due to Flutter not using reflection, we have to
  /// mimic a clone
  @override
  clone(Map<String, dynamic> map) => Vehicle.clone()..fromJson(map);

  static const String keyTableName = 'Vehicle';

  User? get user => get('user');
  set user(User? value) => set('user', value);

  String? get location => get<String?>('location');
  set location(String? value) => set<String?>('location', value);

  String? get description => get<String?>('description');
  set description(String? value) => set<String?>('description', value);

  Brand? get brand => get('brand');
  set brand(Brand? value) => set('brand', value);

  Model? get model => get('model');
  set model(Model? value) => set('model', value);

  List<dynamic>? get photos => get('photos');
  set photos(List<dynamic>? value) => set('photos', value);

  int? get yearOfManufacture => get<int?>('year_of_manufacture');
  set yearOfManufacture(int? value) => set<int?>('year_of_manufacture', value);

  int? get mileage => get<int?>('mileage');
  set mileage(int? value) => set<int?>('mileage', value);

  // int? get vinChassisNumber => get<int?>('vin_chassis_number');
  // set vinChassisNumber(int? value) => set<int?>('vin_chassis_number', value);

  bool? get isRegistered => get<bool?>('is_registered');
  set isRegistered(bool? value) => set<bool?>('is_registered', value);

  bool? get isNegotiable => get<bool?>('is_negotiable');
  set isNegotiable(bool? value) => set<bool?>('is_negotiable', value);

  bool? get isVerified => get<bool?>('is_verified');
  set isVerified(bool? value) => set<bool?>('is_verified', value);

  FuelType? get fuelType => get('fuel_type');
  set fuelType(FuelType? value) => set('fuel_type', value);

  int? get price => get<int?>('price');
  set price(int? value) => set<int?>('price', value);

  ConditionType? get conditionType => get('condition_type');
  set conditionType(ConditionType? value) => set('condition_type', value);

  TransmissionType? get transmissionType => get('transmission_type');
  set transmissionType(TransmissionType? value) =>
      set('transmission_type', value);

  Store? get store => get('store');
  set store(Store? value) => set('store', value);

  int? get views => get<int>('views');
  set views(int? value) => set<int?>('views', value);

  String? get status => get<String?>('status');
  set status(String? value) => set<String?>('status', value);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'objectId': objectId,
      'user': user != null ? user!.toMap() : null,
      'location': location,
      'description': description,
      'brand': brand != null ? brand!.toMap() : null,
      'model': model != null ? model!.toMap() : null,
      'photos': photos,
      'yearOfManufacture': yearOfManufacture,
      'mileage': mileage,
      'isRegistered': isRegistered,
      'isNegotiable': isNegotiable,
      'fuelType': fuelType != null ? fuelType!.toMap() : null,
      'price': price,
      'conditionType': conditionType != null ? conditionType!.toMap() : null,
      'transmissionType':
          transmissionType != null ? transmissionType!.toMap() : null,
      'store': store != null ? store!.toMap() : null,
      'views': views,
    };
  }

  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle()
      ..objectId = map['objectId']
      ..user = User.fromMap(map['user'] ?? <String, dynamic>{})
      ..location = map['location'] != null ? map['location'] as String : null
      ..description =
          map['description'] != null ? map['description'] as String : null
      ..brand = Brand.fromMap(map['brand'] ?? <String, dynamic>{})
      ..model = Model.fromMap(map['model'] ?? <String, dynamic>{})
      ..photos = map['photos'] != null ? map['photos'] as List<dynamic> : null
      ..yearOfManufacture = map['yearOfManufacture'] != null
          ? map['yearOfManufacture'] as int
          : null
      ..mileage = map['mileage'] != null ? map['mileage'] as int : null
      ..isRegistered =
          map['isRegistered'] != null ? map['isRegistered'] as bool : null
      ..isNegotiable =
          map['isNegotiable'] != null ? map['isNegotiable'] as bool : null
      ..fuelType = FuelType.fromMap(map['fuelType'] ?? <String, dynamic>{})
      ..price = map['price'] != null ? map['price'] as int : null
      ..conditionType =
          ConditionType.fromMap(map['conditionType'] ?? <String, dynamic>{})
      ..transmissionType = TransmissionType.fromMap(
          map['transmissionType'] ?? <String, dynamic>{})
      ..store = Store.fromMap(map['store'] ?? <String, dynamic>{})
      ..views = map['views'] != null ? map['views'] as int : null;
  }
}
