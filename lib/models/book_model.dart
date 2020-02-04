class Book {
  String name;
  String location;
  String bookId;
  String createdAt;

  Book({this.name, this.bookId,this.location,String createdAt});

  Book.fromSnap(Map<String,dynamic> data) {
    name = data['name'].toString();
    bookId = data['bookId'].toString();
    location = data['location'].toString();
    createdAt = data['createdAt'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['bookId'] = this.bookId;
    return data;
  }
}
