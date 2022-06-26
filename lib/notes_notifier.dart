import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/notes_model.dart';

class Notifier extends StateNotifier<List<Notes>> {
  Notifier() : super([]);

  void addNote(Notes note) {
    state = [...state, note];
  }
  void removeNote(Notes note) {
    state = state.where((_note) => _note != note).toList();
  }


}
