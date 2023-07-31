
class DataModel {
  final int id;
  final String title;
  final String description;
  final String image;

  DataModel({required this.id, required this.title, required this.description, required this.image});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
        id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image_url'],
    );
  }
}
