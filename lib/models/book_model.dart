class Book {
  String name;
  String location;
  String bookId;
  String createdAt;
  String description;
  JoiningRequirements joiningRequirements;

  Book(
      {this.name,
      this.bookId,
      this.description,
      this.location,
      this.createdAt,
      this.joiningRequirements});

  Book.fromSnap(Map<String, dynamic> data) {
    name = data['name'].toString();
    bookId = data['bookId'].toString();
    description = data['description'].toString();
    location = data['location'].toString();
    createdAt = data['createdAt'].toString();
    joiningRequirements = JoiningRequirements(
        data["joining_requirements"]["roomNo"],
        data["joining_requirements"]["floorNo"],
        data["joining_requirements"]["blockNo"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['bookId'] = this.bookId;
    return data;
  }
}

class JoiningRequirements {
  bool roomNoCheck;
  bool floorNoCheck; 
  bool blockNoCheck;

  JoiningRequirements(this.floorNoCheck, this.roomNoCheck, this.blockNoCheck);

}
