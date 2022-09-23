import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  String _response = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HttpClient Demo'),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 200,
            child: ElevatedButton(
              child: const Text('Send HTTP request'),
              onPressed: () {
                httpRequest();
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                child: Text(_response),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void httpRequest() async {
    try {
      HttpClient client = HttpClient();
      HttpClientRequest request = await client
          .getUrl(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      HttpClientResponse response = await request.close();
      print(response.headers);
      _response = await response.transform(utf8.decoder).join();
      client.close();
    } catch (error) {
      _response = 'Error Occurred : $error';
    } finally {
      setState(() {});
    }
  }
}
