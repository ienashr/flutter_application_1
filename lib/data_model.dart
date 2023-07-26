class DataModel {
  final String title;
  final String description;
  final String image;

  DataModel({required this.title, required this.description, required this.image});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      title: json['title'],
      description: json['description'],
      image: json['image_url'],
    );
  }
}
