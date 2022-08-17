class Plants {
  String? plantId;
  String? name;
  String? description;
  String? imageUrl;
  int? waterCapacity;
  int? sunLight;
  int? temperature;

  Plants({
    this.plantId,
    this.name,
    this.description,
    this.imageUrl,
    this.waterCapacity,
    this.sunLight,
    this.temperature,
  });

  factory Plants.fromJson(Map<String, dynamic> json) => Plants(
        plantId: json['plantId'] as String?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        imageUrl: json['imageUrl'] as String?,
        waterCapacity: json['waterCapacity'] as int?,
        sunLight: json['sunLight'] as int?,
        temperature: json['temperature'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'plantId': plantId,
        'name': name,
        'description': description,
        'imageUrl': imageUrl,
        'waterCapacity': waterCapacity,
        'sunLight': sunLight,
        'temperature': temperature,
      };
}
