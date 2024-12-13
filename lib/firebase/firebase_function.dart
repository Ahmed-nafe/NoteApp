import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled1/model/note_model.dart';

class FirebaseFunction {
  static CollectionReference<NoteModel> getNoteCollection() {
    return FirebaseFirestore.instance
        .collection("notes")
        .withConverter<NoteModel>(fromFirestore: (snapshot, _) {
      return NoteModel.fromJson(snapshot.data()!);
    }, toFirestore: (value, _) {
      return value.toJson();
    });
  }

  static Future<void> addTask(NoteModel noteModel) {
    var collection = getNoteCollection();
    var docRef = collection.doc();
    noteModel.id = docRef.id;
    return docRef.set(noteModel);
  }

  static Future<QuerySnapshot<NoteModel>> getNote() {
    return getNoteCollection().get();
  }

  static Future<void> updateTask(NoteModel noteModel) {
    var collection = getNoteCollection();
    var docRef = collection.doc(noteModel.id);
    return docRef.update(noteModel.toJson());
  }

  static Future<void> deleteNote(String id) {
    return getNoteCollection().doc(id).delete();
  }

  static Future<List<NoteModel>> searchNotes(String query) async {
    var collection = getNoteCollection();
    var snapshot = await collection
        .where('title', isGreaterThanOrEqualTo: query)
        .where('title', isLessThanOrEqualTo: query + '\uf8ff')
        .get();
    print("Results from Firestore: ${snapshot.docs.map((doc) => doc.data()).toList()}");
    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}
