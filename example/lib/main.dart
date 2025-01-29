import 'package:flui_kit/librairy.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final List<Tag> TAGS = [
    Tag(id: "flutter_bloc", label: "Flutter Bloc"),
    Tag(id: "provider", label: "Provider"),
    Tag(id: "go_router", label: "Go Router"),
    Tag(id: "git_flow", label: "Git Flow"),
    Tag(id: "firebase_auth", label: "Firebase Auth"),
    Tag(id: "firebase_crashlytics", label: "Crashlytics"),
    Tag(id: "firestore", label: "Firestore"),
    Tag(id: "flutter_hooks", label: "Flutter Hooks"),
    Tag(id: "firebase_analytics", label: "Firebase Analytics"),
    Tag(id: "git_cherry_pick", label: "Git Cherry Pick"),
    Tag(id: "freezed", label: "Freezed"),
    Tag(id: "git_rebase", label: "Git Rebase"),
    Tag(id: "remote_config", label: "Remote Config"),
    Tag(id: "git_stash", label: "Git Stash"),
    Tag(id: "flame", label: "Flame Engine"),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: TagSelector(
          tags: TAGS,
          initialSelectedTags: [],
          title: 'TAGS',
          titleStyle: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          theme: TagSelectorTheme(
            backgroundColor: Colors.white,
            selectedTagBackground: Colors.blue[50]!,
            availableTagBackground: Colors.grey[100]!,
            borderColor: Colors.blue[200]!,
            iconColor: Colors.blue[400]!,
            borderRadius: 8.0,
            padding: const EdgeInsets.all(16),
            animationDuration: const Duration(milliseconds: 400),
          ),
          maxWidth: 600,
          selectedTagsHeight: 50,
          maxSelectedTags: 2,
          onMaxSelectedTagsReached: () {},
          onSelectionChanged: (selectedTags) {
            print(
                'Selected tags: ${selectedTags.map((t) => t.label).join(', ')}');
          },
        ),
      ),
    );
  }
}
