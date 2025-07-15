import 'package:flutter/material.dart';
import '../models/note.dart';
import '../repositories/notes_repository.dart';

enum NotesState { initial, loading, loaded, error }

class NotesProvider extends ChangeNotifier {
  final NotesRepository _notesRepository = NotesRepository();

  NotesState _state = NotesState.initial;
  List<Note> _notes = [];
  String? _errorMessage;
  bool _isInitialLoad = true;

  NotesState get state => _state;
  List<Note> get notes => _notes;
  String? get errorMessage => _errorMessage;
  bool get isInitialLoad => _isInitialLoad;
  bool get isEmpty => _notes.isEmpty;

  Future<void> fetchNotes(String userId) async {
    if (_isInitialLoad) {
      _state = NotesState.loading;
      notifyListeners();
    }

    try {
      _notes = await _notesRepository.fetchNotes(userId);
      _state = NotesState.loaded;
      _errorMessage = null;
      _isInitialLoad = false;
      notifyListeners();
    } catch (e) {
      _state = NotesState.error;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<bool> addNote(String userId, String text) async {
    try {
      await _notesRepository.addNote(userId, text);
      await fetchNotes(userId); // Refresh the list
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateNote(String userId, String noteId, String text) async {
    try {
      await _notesRepository.updateNote(userId, noteId, text);
      await fetchNotes(userId); // Refresh the list
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteNote(String userId, String noteId) async {
    try {
      await _notesRepository.deleteNote(userId, noteId);
      await fetchNotes(userId); // Refresh the list
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
