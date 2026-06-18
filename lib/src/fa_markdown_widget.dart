import 'package:flutter/cupertino.dart' as cupertino;
import 'package:flutter/material.dart';
import 'package:flutter_artist_core/flutter_artist_core.dart';
import 'package:flutter_artist_styles/flutter_artist_styles.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:url_launcher/url_launcher.dart';

/// A unified wrapper for [MarkdownWidget] rendering, supporting both remote URLs and raw content.
class FaMarkdownWidget extends StatelessWidget {
  /// The reactive future token holding the loaded markdown text layer.
  final Future<String> _markdownFuture;

  /// Default constructor to fetch and render markdown content asynchronously from a remote URL.
  FaMarkdownWidget.url({super.key, required String url})
    : _markdownFuture = _fetchTextFromUrl(url);

  /// Named constructor to render a raw, pre-loaded markdown string directly.
  FaMarkdownWidget.raw({super.key, required String content})
    : _markdownFuture = _fetchTextFromRaw(content);

  /// Internal helper method to delegate execution directly to the cache network driver.
  static Future<String> _fetchTextFromUrl(String url) {
    return FaUrlTextCache.instance.getText(url: url);
  }

  /// Internal helper method to instantly wrap local strings inside a valid Future pipeline context.
  static Future<String> _fetchTextFromRaw(String rawContent) {
    return Future.value(rawContent);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _markdownFuture,
      builder: (context, snapshot) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _buildContent(context, snapshot),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, AsyncSnapshot<String> snapshot) {
    /// Loading state layout implementation
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(
        key: ValueKey('loading'),
        child: cupertino.CupertinoActivityIndicator(),
      );
    }

    /// Error exception handling overlay
    if (snapshot.hasError) {
      return Center(
        key: const ValueKey('error'),
        child: SelectableText(
          "Guide not available yet.\n${snapshot.error}",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: context.faColors.ink.tertiaryQuiet,
            fontSize: 12,
          ),
        ),
      );
    }

    final colors = context.faColors;
    final markdown = snapshot.data ?? "";

    /// Configure typography and layout structures natively mapped to the SaaS style guide
    final config = MarkdownConfig(
      configs: [
        /// Paragraph elements configuration
        PConfig(
          textStyle: TextStyle(
            fontSize: 13,
            height: 1.5,
            color: colors.ink.primary,
          ),
        ),

        /// Headline Level 1 styling configurations
        H1Config(
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: colors.ink.primary,
          ),
        ),

        /// Headline Level 2 styling configurations
        H2Config(
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: colors.ink.primary,
          ),
        ),

        /// Headline Level 3 styling configurations
        H3Config(
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: colors.ink.primary,
          ),
        ),

        /// Inline typography highlight formatting (monospace blocks)
        CodeConfig(
          style: TextStyle(
            color: colors.ink.highlight,
            fontSize: 12,
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
            backgroundColor: colors.surface.muted,
          ),
        ),

        /// Multiline code block syntax visualization surfaces
        PreConfig(
          textStyle: TextStyle(
            fontSize: 12,
            fontFamily: 'monospace',
            color: colors.ink.primary,
            height: 1.4,
          ),
          decoration: BoxDecoration(
            color: colors.surface.muted,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: colors.divider.subtle),
          ),
          padding: const EdgeInsets.all(12),
        ),

        /// Blockquote highlights mapping for emphasis zones
        BlockquoteConfig(
          sideColor: colors.ink.danger,
          textColor: colors.ink.primary,
          sideWith: 4,
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
          margin: const EdgeInsets.symmetric(vertical: 12),
        ),

        /// Redirection anchor navigation triggers hooking natively to platform intent drivers
        LinkConfig(
          style: TextStyle(
            color: colors.ink.highlight,
            decoration: TextDecoration.underline,
          ),
          onTap: (url) async {
            final uri = Uri.tryParse(url);
            if (uri != null) {
              await launchUrl(uri);
            }
          },
        ),

        /// Prefix un-ordered list indents configuration tracking parameters
        ListConfig(marginBottom: 8, marginLeft: 28),

        /// Structural clean line divider decorations
        HrConfig(color: colors.divider.subtle, height: 1),

        /// Matrix grid representation structures complying with framework canvas palettes
        TableConfig(
          border: TableBorder.all(color: colors.divider.subtle),
          headerRowDecoration: BoxDecoration(color: colors.surface.subtle),
          bodyRowDecoration: BoxDecoration(color: colors.surface.standard),
          headerStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: colors.ink.primary,
            fontSize: 13,
          ),
          bodyStyle: TextStyle(color: colors.ink.primary, fontSize: 13),
          headPadding: const EdgeInsets.all(8),
          bodyPadding: const EdgeInsets.all(8),
          wrapper: (child) {
            return SizedBox(width: double.infinity, child: child);
          },
        ),
      ],
    );

    final generator = MarkdownGenerator();
    final widgets = generator.buildWidgets(markdown, config: config);

    return Container(
      key: const ValueKey('markdown'),
      color: colors.surface.standard,
      child: SelectionArea(
        child: ListView(padding: const EdgeInsets.all(8), children: widgets),
      ),
    );
  }
}
