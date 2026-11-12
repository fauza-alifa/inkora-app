import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/providers/search_provider.dart';

class SearchInput extends ConsumerStatefulWidget {
  const SearchInput({super.key});

  @override
  ConsumerState<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends ConsumerState<SearchInput> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = ref.read(searchQueryProvider);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _clear() {
    _controller.clear();
    ref.read(searchQueryProvider.notifier).clear();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    ref.listen(searchQueryProvider, (_, next) {
      if (_controller.text != next) {
        _controller.text = next;
        _controller.selection = TextSelection.collapsed(offset: next.length);
      }
    });

    return SearchBar(
      controller: _controller,
      hintText: 'Cari sesuatu...',
      hintStyle: WidgetStatePropertyAll(
        TextStyle(color: scheme.onSurfaceVariant),
      ),
      textStyle: WidgetStatePropertyAll(TextStyle(color: scheme.onSurface)),
      elevation: const WidgetStatePropertyAll(0),
      backgroundColor: WidgetStatePropertyAll(scheme.surfaceContainer),
      shape: WidgetStatePropertyAll(const StadiumBorder()),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: 20),
      ),
      leading: Icon(Icons.search_rounded, color: scheme.onSurfaceVariant),
      textInputAction: TextInputAction.search,
      onSubmitted: (value) {
        ref.read(searchQueryProvider.notifier).submit(value);
      },
      trailing: [
        ListenableBuilder(
          listenable: _controller,
          builder: (_, _) {
            if (_controller.text.isEmpty) {
              return const SizedBox.shrink();
            }

            return IconButton(
              tooltip: 'Hapus pencarian',
              onPressed: _clear,
              icon: const Icon(Icons.close_rounded),
            );
          },
        ),
      ],
    );
  }
}
