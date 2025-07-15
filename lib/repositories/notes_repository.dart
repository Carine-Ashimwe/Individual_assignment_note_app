import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/note.dart';

class NotesRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference _notesCollection(String userId) {
    return _firestore.collection('users').doc(userId).collection('notes');
  }

  Future<List<Note>> fetchNotes(String userId) async {
    try {
      final snapshot =
          await _notesCollection(
            userId,
          ).orderBy('updatedAt', descending: true).get();

      return snapshot.docs
          .map(
            (doc) =>
                Note.fromFirestore(doc.data() as Map<String, dynamic>, doc.id),
          )
          .toList();
    } catch (e) {
      throw 'Failed to fetch notes: $e';
    }
  }

  Future<void> addNote(String userId, String text) async {
    try {
      final note = Note(
        id: '', // Will be set by Firestore
        text: text,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _notesCollection(userId).add(note.toFirestore());
    } catch (e) {
      throw 'Failed to add note: $e';
    }
  }

  Future<void> updateNote(String userId, String noteId, String text) async {
    try {
      await _notesCollection(userId).doc(noteId).update({
        'text': text,
        'updatedAt': DateTime.now().millisecondsSinceEpoch,
      });
    } catch (e) {
      throw 'Failed to update note: $e';
    }
  }

  Future<void> deleteNote(String userId, String noteId) async {
    try {
      await _notesCollection(userId).doc(noteId).delete();
    } catch (e) {
      throw 'Failed to delete note: $e';
    }
  }

  Stream<List<Note>> watchNotes(String userId) {
    return _notesCollection(userId)
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map(
                    (doc) => Note.fromFirestore(
                      doc.data() as Map<String, dynamic>,
                      doc.id,
                    ),
                  )
                  .toList(),
        );
  }
}
