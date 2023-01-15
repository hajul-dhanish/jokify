class AccListmodel {
  String? userName;
  String? avatar;
  String? id;

  AccListmodel({this.userName, this.avatar, this.id});

  AccListmodel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    avatar = json['avatar'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['userName'] = userName;
    data['avatar'] = avatar;
    data['id'] = id;
    return data;
  }
}