import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/notes_provider.dart';
import '../../widgets/note_card.dart';
import '../../widgets/note_dialog.dart';
import '../../models/note.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen>
    with TickerProviderStateMixin {
  late AnimationController _fabController;
  late Animation<double> _fabAnimation;

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fabAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _fabController, curve: Curves.easeOutBack),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadNotes();
      _fabController.forward();
    });
  }

  @override
  void dispose() {
    _fabController.dispose();
    super.dispose();
  }

  void _loadNotes() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final notesProvider = Provider.of<NotesProvider>(context, listen: false);

    if (authProvider.user != null) {
      notesProvider.fetchNotes(authProvider.user!.uid);
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor:
            isError ? const Color(0xFFEF4444) : const Color(0xFF10B981),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _addNote() async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => const NoteDialog(title: 'New Note'),
    );

    if (!mounted) return;

    if (result != null && result.isNotEmpty) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final notesProvider = Provider.of<NotesProvider>(context, listen: false);

      final success = await notesProvider.addNote(
        authProvider.user!.uid,
        result,
      );

      if (!mounted) return;

      if (success) {
        _showSnackBar('Note saved ✨');
      } else {
        _showSnackBar(
          notesProvider.errorMessage ?? 'Failed to save note',
          isError: true,
        );
      }
    }
  }

  Future<void> _editNote(Note note) async {
    final result = await showDialog<String>(
      context: context,
      builder:
          (context) => NoteDialog(title: 'Edit Note', initialText: note.text),
    );

    if (!mounted) return;

    if (result != null && result != note.text) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final notesProvider = Provider.of<NotesProvider>(context, listen: false);

      final success = await notesProvider.updateNote(
        authProvider.user!.uid,
        note.id,
        result,
      );

      if (!mounted) return;

      if (success) {
        _showSnackBar('Note updated 🎉');
      } else {
        _showSnackBar(
          notesProvider.errorMessage ?? 'Failed to update note',
          isError: true,
        );
      }
    }
  }

  Future<void> _deleteNote(Note note) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Text(
              'Delete Note',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF0F172A),
              ),
            ),
            content: const Text(
              'Are you sure you want to delete this note? This action cannot be undone.',
              style: TextStyle(color: Color(0xFF64748B)),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEF4444),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Delete',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
    );

    if (!mounted) return;

    if (confirmed == true) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final notesProvider = Provider.of<NotesProvider>(context, listen: false);

      final success = await notesProvider.deleteNote(
        authProvider.user!.uid,
        note.id,
      );

      if (!mounted) return;

      if (success) {
        _showSnackBar('Note deleted 🗑️');
      } else {
        _showSnackBar(
          notesProvider.errorMessage ?? 'Failed to delete note',
          isError: true,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFB),
      appBar: AppBar(
        title: const Text('Notes'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Consumer<AuthProvider>(
            builder: (context, authProvider, child) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: IconButton(
                  icon: const Icon(
                    Icons.logout_rounded,
                    color: Color(0xFF64748B),
                    size: 24,
                  ),
                  onPressed: () async {
                    await authProvider.signOut();
                    _showSnackBar('See you later! 👋');
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<NotesProvider>(
        builder: (context, notesProvider, child) {
          if (notesProvider.state == NotesState.loading &&
              notesProvider.isInitialLoad) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Color(0xFF3B82F6),
                    strokeWidth: 3,
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Loading your notes...',
                    style: TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }

          if (notesProvider.state == NotesState.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEF4444).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.error_outline_rounded,
                      size: 48,
                      color: Color(0xFFEF4444),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    notesProvider.errorMessage ?? 'Something went wrong',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: _loadNotes,
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text('Try Again'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          if (notesProvider.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lightbulb_outline_rounded,
                    size: 72,
                    color: Color(0xFFD1D5DB),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Your creative space awaits',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF64748B),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Tap the + button to create your first note',
                    style: TextStyle(fontSize: 16, color: Color(0xFF94A3B8)),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async => _loadNotes(),
            color: const Color(0xFF3B82F6),
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: notesProvider.notes.length,
              itemBuilder: (context, index) {
                final note = notesProvider.notes[index];
                return TweenAnimationBuilder<double>(
                  duration: Duration(milliseconds: 300 + (index * 100)),
                  tween: Tween(begin: 0.0, end: 1.0),
                  curve: Curves.easeOutBack,
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(0, 20 * (1 - value)),
                      child: Opacity(
                        opacity: value,
                        child: NoteCard(
                          note: note,
                          onEdit: () => _editNote(note),
                          onDelete: () => _deleteNote(note),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: ScaleTransition(
        scale: _fabAnimation,
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF3B82F6).withValues(alpha: 0.4),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: FloatingActionButton(
            onPressed: _addNote,
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: const Icon(Icons.add_rounded, color: Colors.white, size: 28),
          ),
        ),
      ),
    );
  }
}
