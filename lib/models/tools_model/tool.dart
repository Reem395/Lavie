class Tool {
  String? toolId;
  String? name;
  String? description;
  String? imageUrl;

  Tool({this.toolId, this.name, this.description, this.imageUrl});

  factory Tool.fromJson(Map<String, dynamic> json) => Tool(
        toolId: json['toolId'] as String?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        imageUrl: json['imageUrl'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'toolId': toolId,
        'name': name,
        'description': description,
        'imageUrl': imageUrl,
      };
}
