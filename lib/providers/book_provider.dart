

import 'package:flutter/cupertino.dart';
import 'package:mealbook/models/book_model.dart';

class BookProvider extends ChangeNotifier {
  List<Book> _foundBookList;

  List<Book> get foundBookList=>_foundBookList;

}
