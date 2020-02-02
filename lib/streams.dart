import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/book_model.dart';

Stream<List<Book>> bookStream(searchKey) {
    return Firestore.instance
        .collection('Books')
        .where("indexes", arrayContains: searchKey)
        .snapshots()
        .map((qsnap) => qsnap.documents
            .map((document) => Book.fromSnap(document.data))
            .toList());
  }