import "package:introduction_repository_interface/src/enums/image_mode.dart";

class IntroductionPageData {
  const IntroductionPageData({
    required this.id,
    required this.title,
    required this.description,
    required this.graphic,
    this.imageMode = ImageMode.asset,
  });

  factory IntroductionPageData.fromJson(Map<String, dynamic> json) =>
      IntroductionPageData(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        graphic: json["graphic"],
        imageMode:
            json["imageMode"] == "asset" ? ImageMode.asset : ImageMode.network,
      );

  final int id;
  final String title;
  final String description;
  final String graphic;
  final ImageMode imageMode;

  //tojson

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "graphic": graphic,
        "imageMode": imageMode == ImageMode.asset ? "asset" : "network",
      };
}
