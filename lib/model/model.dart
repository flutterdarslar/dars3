// "userId": 3,
// "id": 27,
// "title": "quasi id et eos tenetur aut quo autem",
// "body"

class ModelUser {
  dynamic userid;
  dynamic id;
  dynamic title;
  dynamic body;

  ModelUser({

     this.userid,
     this.id,
     this.title,
     this.body,
  });

  factory ModelUser.fromJson(Map<String, dynamic> json) {
    return ModelUser(
      userid: json["userId"],
      id: json["id"],
      title: json["title"],
      body: json["body"],
    );
  }
}
