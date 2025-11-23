import 'package:cloud_firestore/cloud_firestore.dart';

class TaskRemoteSource {
  final FirebaseFirestore firestore;

  TaskRemoteSource(this.firestore);

  Stream<QuerySnapshot<Map<String, dynamic>>> streamTasks(String email) {
    return firestore
        .collection("tasks")
        .where("sharedWith", arrayContains: email)
        .orderBy("updatedAt", descending: true)
        .snapshots();
  }

  Future<void> addTask(String id, Map<String, dynamic> data) async {
    await firestore.collection('tasks').doc(id).set(data);
  }

  Future<void> updateTask(String id, Map<String, dynamic> data) async {
    await firestore.collection('tasks').doc(id).update(data);
  }

  Future<void> shareTask(String id, String email) async {
    await firestore.collection('tasks').doc(id).update({
      'sharedWith': FieldValue.arrayUnion([email]),
    });
  }

  Future<void> deleteTask(String id) {
    return firestore.collection("tasks").doc(id).delete();
  }
}
