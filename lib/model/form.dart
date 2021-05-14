/// FeedbackForm is a data class which stores data fields of Feedback.
class FeedbackForm {
  String name;
  String description;
  String type;
  String photo;
  String address;

  FeedbackForm(this.name, this.description, this.type, this.photo, this.address);

  factory FeedbackForm.fromJson(dynamic json) {
    return FeedbackForm(
        "${json['name']}",
        "${json['description']}",
        "${json['type']}",
        "${json['photo']}",
        "${json['address']}"
    );
  }

  // Method to make GET parameters.
  Map toJson() => {
    'name': name,
    'description': description,
    'type': type,
    'photo': photo,
    'address': address
  };
}