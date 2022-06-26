import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'notes_model.dart';
import 'notes_notifier.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}
final noteProvider = StateNotifierProvider<Notifier, List<Notes>>((ref) => Notifier());

class Home extends ConsumerWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesList = ref.watch(noteProvider);
    final titleController = TextEditingController();
    final contentController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes App'),
      ),
      body: Column(
        children: [
          ElevatedButton(onPressed: () {
            showDialog(context: context, builder: (_){
              return AlertDialog(
                content: Column(
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: contentController,
                      decoration: InputDecoration(
                        labelText: 'Content',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
                actions: [
                  ElevatedButton(onPressed: () {
                    ref.read(noteProvider.notifier).addNote(Notes(
                      title: titleController.text,
                      content: contentController.text,
                    ));
                    Navigator.pop(context);
                  }, child: const Text('Add note')),
                ],
              );
            });
          }, child: const Text('Add Note')),
          const SizedBox(height: 20),
          notesList.isEmpty? const Text('Add notes ')
              : ListView.builder(
            itemCount: notesList.length,
            shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                title: Text(notesList[index].title),
                  subtitle: Text(notesList[index].content),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      ref.read(noteProvider.notifier).removeNote(notesList[index]);
                    },
                  ),
                );
              })
        ],
      )
    );
  }
}
