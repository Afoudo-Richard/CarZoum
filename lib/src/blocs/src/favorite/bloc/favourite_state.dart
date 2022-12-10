// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'favourite_bloc.dart';

enum FavouriteStatus {
  initial,
  vehicleExist,
  vehicleRemoved,
  vehicleAdded,
  cleared
}

class FavouriteState extends Equatable {
  final FavouriteStatus favouriteStatus;
  final List<Vehicle> vehicles;

  FavouriteState({
    this.favouriteStatus = FavouriteStatus.initial,
    this.vehicles = const [],
  });

  @override
  List<Object> get props => [vehicles, favouriteStatus];

  bool vehicleInFavourite(Vehicle vehicle) {
    return vehicles.contains(vehicle);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'favouriteStatus': favouriteStatus.name,
      'vehicles': vehicles.map((x) => x.toMap()).toList(),
    };
  }

  factory FavouriteState.fromMap(Map<String, dynamic> map) {
    return FavouriteState(
      favouriteStatus:
          FavouriteStatus.values.byName(map['favouriteStatus'] as String),
      vehicles: List<Vehicle>.from(
        (map['vehicles'] as List<Map<String, dynamic>>).map<Vehicle>(
          (x) => Vehicle.fromMap(x),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory FavouriteState.fromJson(String source) =>
      FavouriteState.fromMap(json.decode(source) as Map<String, dynamic>);

  FavouriteState copyWith({
    FavouriteStatus? favouriteStatus,
    List<Vehicle>? vehicles,
  }) {
    return FavouriteState(
      favouriteStatus: favouriteStatus ?? this.favouriteStatus,
      vehicles: vehicles ?? this.vehicles,
    );
  }
}
