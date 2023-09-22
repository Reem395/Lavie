import '../plants_model/plants.dart';
import '../seeds_model/seeds.dart';
import '../tools_model/tool.dart';

class Blogs {
  List<Plants>? plants;
  List<Seeds>? seeds;
  List<Tool>? tools;

  Blogs({this.plants, this.seeds, this.tools});

  factory Blogs.fromJson(Map<String, dynamic> json) => Blogs(
        plants: (json['plants'] as List<dynamic>?)
            ?.map((e) => Plants.fromJson(e as Map<String, dynamic>))
            .toList(),
        seeds: (json['seeds'] as List<dynamic>?)
            ?.map((e) => Seeds.fromJson(e as Map<String, dynamic>))
            .toList(),
        tools: (json['tools'] as List<dynamic>?)
            ?.map((e) => Tool.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'plants': plants?.map((e) => e.toJson()).toList(),
        'seeds': seeds?.map((e) => e.toJson()).toList(),
        'tools': tools?.map((e) => e.toJson()).toList(),
      };
}
