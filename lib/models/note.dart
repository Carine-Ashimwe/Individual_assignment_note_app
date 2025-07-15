class Note {
  final String id;
  final String text;
  final DateTime createdAt;
  final DateTime updatedAt;

  Note({
    required this.id,
    required this.text,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Note.fromFirestore(Map<String, dynamic> data, String id) {
    return Note(
      id: id,
      text: data['text'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(data['createdAt']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(data['updatedAt']),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'text': text,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  Note copyWith({
    String? id,
    String? text,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Note(
      id: id ?? this.id,
      text: text ?? this.text,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
