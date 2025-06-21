class PostalCodeFormat {
  final String countryCode;
  final String? format;
  final RegExp? regexPattern;

  PostalCodeFormat({
    required this.countryCode,
    required this.format,
    required this.regexPattern,
  });
}
