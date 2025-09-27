import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
	final FirebaseFirestore _firestore = FirebaseFirestore.instance;

	Future<DocumentSnapshot<Map<String, dynamic>>> getDocument(String collection, String docId) async {
		return await _firestore.collection(collection).doc(docId).get();
	}

	Future<void> setDocument(String collection, String docId, Map<String, dynamic> data) async {
		await _firestore.collection(collection).doc(docId).set(data);
	}

	Future<void> deleteDocument(String collection, String docId) async {
		await _firestore.collection(collection).doc(docId).delete();
	}
}
