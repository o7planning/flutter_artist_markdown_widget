# flutter_artist_markdown_widget

A premium, modular markdown rendering extension widget tailored for the **FlutterArtist** ecosystem.

##  Overview

`flutter_artist_markdown_widget` serves as a high-level wrapper built directly on top of the excellent [markdown_widget](https://pub.dev/packages/markdown_widget) package. It is designed explicitly to render documentation manuals, interactive user guides, and feature walkthroughs inside `FlutterArtist` applications with zero-configuration required.

###  Out-of-the-Box SaaS Styling
By default, this package injects pre-configured style definitions (including customized typography headers, clean code syntax visualization surfaces, modern matrix representation tables, and specific spacing) that match the professional SaaS layout system specifications of the core framework.

### ⚖️ Flexibility vs. Granular Control
* **The Wrapper (`FaMarkdownWidget`):** Use this for quick, standard rendering of documentation with native theme colors (`context.faColors`) mapped automatically.
* **Go Direct:** If your specific feature context demands complete style control, customized parser rules, or non-standard rendering behavior, **you are highly encouraged to directly use the core `markdown_widget` package** instead of this wrapper.

---

##  Key Features

* **Dual Initialization Vectors:** Supports asynchronous remote URL text fetching (backed by automatic caching mechanisms) as well as direct raw string ingestion.
* **Theme-Connected:** Automatically binds text, background containers, dividers, and link accents to the underlying application palette tokens.
* **Text Selection Enabled:** Wrapped inside a `SelectionArea` structure to allow desktop and mobile users to easily copy snippets.

---

## ️ Usage

This package provides two simple constructor profiles depending on your target data layout sourcing requirement.

### Scenario A: Fetch and Render from a Remote URL
Ideal for loading centralized app user manuals or dynamically updated changelogs fetched directly from cloud repositories.

```dart
import 'package:flutter_artist_markdown_widget/flutter_artist_markdown_widget.dart';

const Widget myRemoteGuide = FaMarkdownWidget.url(
  url: 'https://example.com/docs/v1/intro.md', //
);
```

### Scenario B: Render from a Local Raw Markdown String
Perfect for offline descriptive guidelines, static layout tooltips, or local configuration strings.

```dart
import 'package:flutter_artist_markdown_widget/flutter_artist_markdown_widget.dart';

const Widget myLocalGuide = FaMarkdownWidget.raw(
  content: '''
  # ️ Core Specification
  * **Feature 1:** Automated memory pruning.
  * **Feature 2:** Leak-proof architecture.
  ''',
);
```

---

## ⛓️ Installation

Declare this package inside your operational environment configurations file `pubspec.yaml`:

```yaml
dependencies:
  flutter_artist_markdown_widget: ^0.9.0
```

*Note: This extension package requires the implementation context of the baseline `flutter_artist` toolkit to map system layout behaviors correctly.*