class Seeds {
  String? seedId;
  String? name;
  String? description;
  String? imageUrl;

  Seeds({this.seedId, this.name, this.description, this.imageUrl});

  factory Seeds.fromJson(Map<String, dynamic> json) => Seeds(
        seedId: json['seedId'] as String?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        imageUrl: json['imageUrl'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'seedId': seedId,
        'name': name,
        'description': description,
        'imageUrl': imageUrl,
      };
}
