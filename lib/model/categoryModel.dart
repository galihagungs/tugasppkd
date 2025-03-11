class Categorymodel {
  String? slug;
  String? name;
  String? images;

  Categorymodel({this.slug, this.name, this.images});

  Categorymodel.fromJson(Map<String, dynamic> json) {
    slug = json['slug'];
    name = json['name'];
    images = json['images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slug'] = this.slug;
    data['name'] = this.name;
    data['images'] = this.images;
    return data;
  }
}
