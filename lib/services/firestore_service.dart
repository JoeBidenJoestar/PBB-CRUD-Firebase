import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference notes = FirebaseFirestore.instance.collection('notes');

  // create new note
  Future<void> addNote(String title, String content, String date, String label) {
    return notes.add({
      'title': title,
      'content': content,
      'date': date,
      'label': label,
      'createdAt': Timestamp.now(),
    });
  }

  // fetch all notes
  Stream<QuerySnapshot> getNotes() {
    return notes.orderBy('createdAt', descending: true).snapshots();
  }

  // update notes
  Future<void> updateNote(String id, String title, String content, String date, String label) {
    return notes.doc(id).update({
      'title': title,
      'content': content,
      'date': date,
      'label': label,
      'createdAt': Timestamp.now(), // update the 'createdAt' to push it to the top OR we might want to preserve the original creation time and add 'updatedAt'. Here we follow the repo.
    });
  }

  // delete notes
  Future<void> deleteNote(String id) {
    return notes.doc(id).delete();
  }
}
