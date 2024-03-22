import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const QuoteApp());
}

class QuoteApp extends StatelessWidget {
  const QuoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zitate App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        brightness: Brightness.light,
      ),
      home: const QuotePage(),
    );
  }
}

class QuotePage extends StatefulWidget {
  const QuotePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _QuotePageState createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {
  String _quote = '';
  String _author = '';

  @override
  void initState() {
    super.initState();
    _fetchQuote();
  }

  Future<void> _fetchQuote() async {
    final response =
        await http.get(Uri.parse('https://api.quotable.io/random?lang=de'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _quote = data['content'];
        _author = data['author'];
      });
    } else {
      throw Exception('Fehler beim Laden des Zitats');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zitate App'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.yellow.shade200,
                Colors.orange.shade300,
                Colors.red.shade400,
                Colors.deepPurple.shade600,
              ],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.yellow.shade200,
              Colors.orange.shade300,
              Colors.red.shade400,
              Colors.deepPurple.shade600,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Column(
                  children: [
                    Text(
                      _quote,
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontFamily: 'Pacifico',
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      '- $_author',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'Raleway',
                        fontStyle: FontStyle.italic,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: _fetchQuote,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                child: const Text(
                  'Neues Zitat',
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
