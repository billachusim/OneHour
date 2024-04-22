class AppliedCareer {
  String? title;
  String? image;
  String? careerId;
  String? description;
  String? duration;
  String? cost;
  String? certPointLoad;
  String? status;
  bool? featured;


  AppliedCareer({
    this.title,
    this.image,
    this.careerId,
    this.description,
    this.duration,
    this.cost,
    this.certPointLoad,
    this.status,
    this.featured,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'image': image,
      'careerId': careerId,
      'description': description,
      'duration': duration,
      'cost': cost,
      'certPointLoad': certPointLoad,
      'status': status,
      'featured': featured,
    };
  }

  factory AppliedCareer.fromJson(Map<String, dynamic> json) {
    return AppliedCareer(
      title: json['title'],
      image: json['image'],
      careerId: json['careerId'],
      description: json['description'],
      duration: json['duration'],
      cost: json['cost'],
      certPointLoad: json['certPointLoad'],
      status: json['status'],
      featured: json['featured'],
    );
  }
}
