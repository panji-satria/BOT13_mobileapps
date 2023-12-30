import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: ChatScreen(),
  ));
}

class NLPContentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NLP Content'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Natural Language Processing (NLP)',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Explore content related to Natural Language Processing (NLP)',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Activate NLP algorithm
                  runNLPAlgorithm(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Run NLP Algorithm',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Key Concepts in NLP',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildNLPFeature('Chatbots', Icons.chat),
                          _buildNLPFeature('Sentiment Analysis', Icons.sentiment_satisfied),
                          _buildNLPFeature('Language Translation', Icons.language),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Hero(
                tag: 'nlp_animation',
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.network(
                      'https://placekitten.com/400/200',
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Explore more about NLP:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              _buildNLPResource('NLP Basics', Icons.book),
              _buildNLPResource('Advanced NLP Techniques', Icons.school),
            ],
          ),
        ),
      ),
    );
  }

  // Activate NLP algorithm
  void runNLPAlgorithm(BuildContext context) {
    // Add logic or call NLP function here
    print('Running NLP Algorithm...');

    // Example: Display NLP result dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('NLP Result'),
        content: Text('The NLP algorithm has been executed successfully!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildNLPFeature(String title, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          size: 40,
          color: Colors.blue,
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildNLPResource(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        print('Navigating to $title');
      },
    );
  }
}

class NLPResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NLP Results'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'NLP Results',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Results of the Natural Language Processing (NLP) algorithm.',
              style: TextStyle(
                fontSize: 16,
                color: const Color.fromARGB(255, 248, 248, 248),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NLPContentScreen()),
            );
          },
          child: Text('Go to NLP Content'),
        ),
      ),
    );
  }
}
