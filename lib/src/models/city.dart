class City {
  final String name;
  final String countryCode;
  final String stateCode;
  final String? latitude;
  final String? longitude;
  //the postal code for cities is generated using geocoding based on lat and long of cities- 04-06-2025
  final String postalCode;
  late final String isoCode;

  City({
    required this.name,
    required this.countryCode,
    required this.stateCode,
    required this.postalCode,
    this.latitude,
    this.longitude,
  }) {
    isoCode = "${name}_$stateCode";
  }

  static City fromJson(Map<String, dynamic> json) => City(
        name: json['name'],
        countryCode: json['countryCode'],
        stateCode: json['stateCode'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        postalCode: json['postalCode'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'countryCode': countryCode,
        'stateCode': stateCode,
        'latitude': latitude,
        'longitude': longitude,
        'isoCode': isoCode,
        'postalCode': postalCode,
      };

  @override
  bool operator ==(Object other) {
    return other is City && other.name == name && other.countryCode == countryCode && other.stateCode == stateCode;
  }

  @override
  int get hashCode => Object.hashAll([name, countryCode, stateCode]);
}
