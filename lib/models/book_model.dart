class Book {
  String name;
  String bookId;

  Book({this.name, this.bookId});

  Book.fromSnap(Map<String,dynamic> data) {
    name = data['name'].toString()??'wait for name';
    bookId = data['bookId'].toString()??'wait for bookId';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['bookId'] = this.bookId;
    return data;
  }
}
