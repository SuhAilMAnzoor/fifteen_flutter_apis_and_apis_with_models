class SinglePostModel {
  int? userId;
  int? id;
  String? title;
  String? body;

  SinglePostModel({this.userId, this.id, this.title, this.body});

  SinglePostModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}


// This model (Single post model) is applied for
// file flutter_api_two_single_post_model.dart  and
// file flutter_api_three_single_posts_model_i.dart


