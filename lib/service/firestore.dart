import 'package:cloud_firestore/cloud_firestore.dart';

// TODO: Catch exceptions
class FirestoreService {
  FirestoreService._();
  static final instance = FirestoreService._();

  DocumentSnapshot? lastUserDocument;

  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
    bool showDebug = true,
    bool merge = false,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.set(data, SetOptions(merge: merge));
  }

  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    bool showDebug = true,
  }) async {
    final reference = FirebaseFirestore.instance.collection(path);
    await reference.add(data);
  }

  Future<void> updateData({
    required String path,
    required Map<String, dynamic> data,
    bool showDebug = true,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.update(data);
  }

  Future<void> deleteData({required String path}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.delete();
  }

  Future<T> getDocument<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentID) builder,
  }) async {
    final fireStoreItem = await FirebaseFirestore.instance.doc(path).get();
    return builder(fireStoreItem.data(), fireStoreItem.id);
  }

  Future<List<T>> getCollectionGroup<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentID) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
    int? limit,
  }) async {
    Query query = FirebaseFirestore.instance.collectionGroup(path);

    if (queryBuilder != null) query = queryBuilder(query);

    if (limit != null) query = query.limit(limit);

    final QuerySnapshot queryDoc = await query.get();

    final List<T> listItems = queryDoc.docs
        .map((snapshot) => builder(
            snapshot.data() as Map<String, dynamic>?, snapshot.reference.path))
        .toList();

    return listItems;
  }

  Future<List<T>> getCollection<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentID) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
    int? limit,
  }) async {
    Query query = FirebaseFirestore.instance.collection(path);

    if (queryBuilder != null) query = queryBuilder(query);

    if (limit != null) query = query.limit(limit);

    final QuerySnapshot queryDoc = await query.get();

    final List<T> listItems = queryDoc.docs
        .map((snapshot) =>
            builder(snapshot.data() as Map<String, dynamic>?, snapshot.id))
        .toList();

    return listItems;
  }

  Stream<List<T>> collectionStream<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentID) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
    int? limit,
  }) {
    Query query = FirebaseFirestore.instance.collection(path);

    if (limit != null) query = query.limit(limit);

    if (queryBuilder != null) query = queryBuilder(query);

    final Stream<QuerySnapshot> snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      if (snapshot.docs.isNotEmpty) lastUserDocument = snapshot.docs.last;
      final result = snapshot.docs
          .map((snapshot) =>
              builder(snapshot.data() as Map<String, dynamic>?, snapshot.id))
          .where((value) => value != null)
          .toList();
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }

  Stream<T> documentStream<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentID) builder,
  }) {
    final DocumentReference reference = FirebaseFirestore.instance.doc(path);
    final Stream<DocumentSnapshot> snapshots = reference.snapshots();

    return snapshots.map((snapshot) =>
        builder(snapshot.data() as Map<String, dynamic>?, snapshot.id));
  }

  Future<bool> checkIfDocExists({
    required String collectionPath,
    required String docId,
  }) async {
    try {
      var collectionRef = FirebaseFirestore.instance.collection(collectionPath);
      var doc = await collectionRef.doc(docId).get();
      return doc.exists;
    } catch (e) {
      return false;
    }
  }
}
