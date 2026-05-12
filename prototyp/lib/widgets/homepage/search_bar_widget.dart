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
  final TextEditingController _controller = TextEditingController();
  late stt.SpeechToText _speech;
  bool _isListening = false;

  Future<void> _triggerSearch(String value) async {
    final query = value.trim();

    if (_isListening) {
      setState(() => _isListening = false);
      await _speech.stop();
    }
    if (query.isNotEmpty) {
      widget.onSearch(query);
    }
  }

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300,
        child: TextField(
          controller: _controller,
          textInputAction: TextInputAction.search,
          onSubmitted: (value) async {
            await _triggerSearch(value);

            FocusScope.of(context).unfocus();
          },
          decoration: InputDecoration(
            hintText: "Sök efter varor",
            prefixIcon: const Icon(Icons.search),

            suffixIcon: IconButton(
              icon: Icon(
                _isListening ? Icons.mic : Icons.mic_off,
                color: _isListening ? Colors.red : Colors.grey,
              ),
              onPressed: () async {
                if (!_isListening) {
                  bool available = await _speech.initialize(
                    onStatus: (status) {
                      if (status == 'done') {
                        setState(() => _isListening = false);
                      }
                    },
                  );

                  if (available) {
                    setState(() => _isListening = true);

                    _speech.listen(
                      onResult: (result) {
                        setState(() {
                          _controller.text = result.recognizedWords;
                        });
                      },
                    );
                  }
                } else {
                  await _triggerSearch(_controller.text);
                }
              },
            ),

            contentPadding: const EdgeInsets.symmetric(vertical: 10),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
