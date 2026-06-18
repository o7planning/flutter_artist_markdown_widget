import 'package:flutter/material.dart';
import 'package:flutter_artist_markdown_widget/flutter_artist_markdown_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterArtist Markdown Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF003366), // Dark Navy SaaS Theme
      ),
      home: const MarkdownExampleScreen(),
    );
  }
}

class MarkdownExampleScreen extends StatefulWidget {
  const MarkdownExampleScreen({super.key});

  @override
  State<MarkdownExampleScreen> createState() => _MarkdownExampleScreenState();
}

class _MarkdownExampleScreenState extends State<MarkdownExampleScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          ' FlutterArtist Markdown Widget',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              icon: Icon(Icons.cloud_download_rounded),
              text: 'Remote URL (Cached)',
            ),
            Tab(icon: Icon(Icons.code_rounded), text: 'Raw Markdown String'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Scenario A: Rendering from a remote server with automatic cache mechanism
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FaMarkdownWidget.url(
              url: 'https://pub.dev/packages/flutter_artist_markdown_widget', //
            ),
          ),

          // Scenario B: Rendering from a raw local or dynamic configuration string directly
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FaMarkdownWidget.raw(content: _getSampleRawMarkdown()),
          ),
        ],
      ),
    );
  }

  String _getSampleRawMarkdown() {
    return '''
# ️ FlutterArtist Core Ecosystem
Welcome to the high-performance SaaS framework specification driver.

##  Key Architectural Advantages
* **Leak-Proof Architecture:** Automatic Garbage Collection sweeps unused resources every 30 seconds.
* **High-End UI Components:** Native styling configured directly via unified context tokens.
* **Modular Integration:** Only import the specific packages your application layer actually demands.

### ️ Sample Monospace Block
```dart
void main() {
  // Seamless instantiation paradigm
  print("FlutterArtist Initialized!");
}
``` 

###  System Capability Evaluation Matrix
| Capability | Core Engine | Markdown Component |
| :--- | :---: | :---: |
| Memory Pruning | Autonomous | Light-weight |
| Cross-Platform | Verified | Seamless |

> **Retaining Logic Note:** If you re-open an unmounted feature module before the 30-second sweep window completes, the framework reactivates the target context safely.
''';
  }
}
