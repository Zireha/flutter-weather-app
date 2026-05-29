class SearchLocationModel {
  final int id;
  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;
  final String url;

  SearchLocationModel({
    required this.id,
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.url,
  });

  factory SearchLocationModel.fromJson(Map<String, dynamic> json) {
    return SearchLocationModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      region: json['region'] ?? '',
      country: json['country'] ?? '',
      lat: (json['lat'] as num?)?.toDouble() ?? 0.0,
      lon: (json['lon'] as num?)?.toDouble() ?? 0.0,
      url: json['url'] ?? '',
    );
  }

  // Method untuk mengubah object kembali menjadi JSON map (opsional, jika dibutuhkan)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'region': region,
      'country': country,
      'lat': lat,
      'lon': lon,
      'url': url,
    };
  }
}
