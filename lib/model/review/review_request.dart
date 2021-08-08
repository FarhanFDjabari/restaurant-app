class ReviewRequest {
  late String id;
  late String name;
  late String review;

  ReviewRequest({
    required this.id,
    required this.name,
    required this.review,
  });

  ReviewRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    review = json['review'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['review'] = this.review;
    return data;
  }
}
