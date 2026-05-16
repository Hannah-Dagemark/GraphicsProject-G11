import 'package:flutter/material.dart';
import 'package:prototyp/model/imat/imat_data_handler.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SearchBarWidget extends StatefulWidget {
  final Function(String) onSearch;

  const SearchBarWidget({super.key, required this.onSearch});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late stt.SpeechToText _speech;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  Future<void> _toggleListening(TextEditingController controller) async {
    if (!_isListening) {
      bool available = await _speech.initialize();

      if (available) {
        setState(() => _isListening = true);

        _speech.listen(
          onResult: (result) {
            setState(() {
              controller.text = result.recognizedWords;
              controller.selection = TextSelection.fromPosition(
                TextPosition(offset: controller.text.length),
              );
            });
          },
        );
      }
    } else {
      setState(() => _isListening = false);
      await _speech.stop();
      widget.onSearch(controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final handler = context.watch<ImatDataHandler>();

    return Center(
      child: SizedBox(
        width: 300,
        child: Autocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            final text = textEditingValue.text.trim();

            if (text.isEmpty) {
              return const Iterable<String>.empty();
            }

            final handler = context.read<ImatDataHandler>();
            final products = handler.findProducts(text);

            return products.map((p) => p.name);
          },

          onSelected: (String selection) {
            widget.onSearch(selection);
          },

          fieldViewBuilder:
              (context, controller, focusNode, onEditingComplete) {
                return TextField(
                  controller: controller,
                  focusNode: focusNode,
                  textInputAction: TextInputAction.search,

                  onSubmitted: (value) {
                    widget.onSearch(value);
                  },

                  decoration: InputDecoration(
                    hintText: "Sök efter varor",
                    prefixIcon: const Icon(Icons.search),

                    suffixIcon: IconButton(
                      icon: Icon(
                        _isListening ? Icons.mic : Icons.mic_off,
                        color: _isListening ? Colors.red : Colors.grey,
                      ),
                      onPressed: () => _toggleListening(controller),
                    ),

                    filled: true,
                    fillColor: Colors.white,

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                );
              },
        ),
      ),
    );
  }
}
