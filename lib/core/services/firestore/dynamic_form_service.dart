import 'package:cloud_firestore/cloud_firestore.dart';

class DynamicFormService {
	final FirebaseFirestore _firestore = FirebaseFirestore.instance;

	Future<Map<String, dynamic>?> fetchFormConfig(String formName) async {
		final doc = await _firestore.collection('forms').doc(formName).get();
		return doc.data();
	}

	Future<void> saveFormData(String formName, Map<String, dynamic> data) async {
		await _firestore.collection('form_data').add({
			'form': formName,
			'data': data,
			'timestamp': FieldValue.serverTimestamp(),
		});
	}
}
