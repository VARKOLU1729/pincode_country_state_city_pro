class Country {
  String? name;
  String? isoCode;
  String? dialCode;
  String? flagUri;

  Country({
    this.name,
    this.isoCode,
    this.dialCode,
    this.flagUri,
  });

  factory Country.fromJson(Map<String, dynamic> data) {
    return Country(
      name: data['name'],
      isoCode: data['isoCode'],
      dialCode: data['dial_code'],
      flagUri: 'assets/flags/${data['isoCode'].toLowerCase()}.png',
    );
  }

  @override
  bool operator ==(Object other) {
    return other is Country && other.name == name && other.isoCode == isoCode;
  }

  @override
  int get hashCode => Object.hashAll([name, isoCode]);
}
