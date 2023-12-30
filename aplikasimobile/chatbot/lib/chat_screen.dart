import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

bool isBotTyping = false;

const String flaskServerUrl = 'http://127.0.0.1:5000';

class Message {
  final String text;
  final bool isUser;

  Message(this.text, this.isUser);
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<String> locations = ['Yogyakarta', 'Jakarta', 'Jombang', 'Bandung'];
  String location = 'Yogyakarta';
  final List<Message> messages = [];
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void changeLocation(String newLocation) {
    setState(() {
      location = newLocation;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> sendMessageToFlask(String message) async {
    try {
      final response = await Dio().post(
        '$flaskServerUrl/models', // Correct URL format
        data: {'message': message},
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        print('Message sent successfully');
      } else {
        print('Error sending message: ${response.statusMessage}');
      }
    } catch (e) {
      print('Exception while sending message: $e');
    }
  }

  String processRasaResponse(String response) {
    final Map<String, dynamic> jsonResponse = json.decode(response);
    return jsonResponse.isNotEmpty ? jsonResponse['text'].toString() : 'No response';
  }

  String getManualBotResponse(String userMessage) {
    userMessage = userMessage.toLowerCase();

    if (userMessage.contains('apa kabar') || userMessage.contains('gimana kabar')) {
      return 'BOT13: Saya baik, terima kasih!';
    } else if (userMessage.contains('siapa namamu')) {
      return 'BOT13: Saya adalah BOT13, siap membantu anda.';
    } else if (userMessage.contains('bagaimana cuaca')) {
      return 'Maaf, saya tidak bisa memberikan informasi cuaca saat ini.';
    } else if (userMessage.contains('halo') || userMessage.contains('hai') || userMessage.contains('hi')) {
      return 'BOT13: Halo! Ada yang bisa saya bantu?';
    } else if (userMessage.contains('terima kasih') || userMessage.contains('thanks')) {
      return 'BOT13: Sama-sama, senang bisa membantu!';
    } else if (userMessage.contains('apakah kamu suka musik')) {
      return 'BOT13: Saya tidak memiliki preferensi musik, tapi saya suka membantu Anda dengan pertanyaan!';
    } else if (userMessage.contains('berapa umur kamu')) {
      return 'BOT: Saya hanyalah program komputer, jadi saya tidak memiliki umur!';
    } else if (userMessage.contains('ada berita terbaru')) {
      return 'Maaf, saya tidak dapat memberikan berita terbaru saat ini. Silakan cek sumber berita terpercaya.';
    } else if (userMessage.contains('mahasiswa uad') || userMessage.contains('uad')) {
      return 'BOT13: Universitas Ahmad Dahlan (UAD) adalah universitas di Yogyakarta, Indonesia. Apakah ada informasi tertentu yang ingin Anda ketahui?';
    } else if (userMessage.contains('kuliah di uad') || userMessage.contains('prodi uad')) {
      return 'BOT13: UAD menawarkan berbagai program studi di tingkat sarjana dan pascasarjana. Anda dapat mengunjungi situs resmi UAD untuk informasi lebih lanjut.';
    } else if (userMessage.contains('akreditasi uad')) {
      return 'BOT13: UAD memiliki akreditasi yang baik untuk sejumlah program studi. Untuk informasi lebih lanjut, silakan cek situs web resmi UAD.';
    } else if (userMessage.contains('fasilitas kampus uad')) {
      return 'BOT13: UAD memiliki berbagai fasilitas kampus, termasuk perpustakaan, laboratorium, dan pusat kegiatan mahasiswa. Untuk detail lebih lanjut, Anda dapat menghubungi pihak kampus.';
    } else if (userMessage.contains('beasiswa uad')) {
      return 'BOT13: UAD menyediakan berbagai jenis beasiswa untuk mahasiswa berprestasi. Informasi lebih lanjut dapat ditemukan di situs web resmi atau hubungi bagian akademik.';
    } else if (userMessage.contains('rekomendasi makanan di jogja') || userMessage.contains('kuliner jogja')) {
      return 'BOT13: Jogja terkenal dengan berbagai kuliner lezat! Beberapa rekomendasi makanan di Jogja termasuk Gudeg, Nasi Kucing, Bakmi Jawa, dan Ayam Goreng Kalasan. Selamat mencoba!';
    } else if (userMessage.contains('restoran romantis di jogja')) {
      return 'BOT13: Untuk suasana romantis, Anda bisa mencoba restoran seperti Mediterranea Restaurant, The House of Raminten, atau Lokal Hotel & Restaurant. Semoga Anda memiliki pengalaman kuliner yang menyenangkan!';
    } else {
      return 'BOT13: Maaf, saya tidak mengerti pertanyaan Anda.';
    }
  }

  void _handleSubmitted(String text) async {
    try {
      setState(() {
        messages.add(Message(text, true));
        isBotTyping = true;
      });

      await Future.delayed(Duration(seconds: 1));

      if (text.toLowerCase().contains('cuaca')) {
        final weatherResponse = 'Cuaca di $location: Cerah, Suhu: 28°C';

        setState(() {
          messages.add(Message(weatherResponse, false));
          isBotTyping = false;
        });
      } else {
        await sendMessageToFlask(text);

        await Future.delayed(Duration(seconds: 1));

        final botResponse = getManualBotResponse(text);

        setState(() {
          messages.add(Message(botResponse, false));
          isBotTyping = false;
        });
      }

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } catch (e) {
      print('Error handling submission: $e');
    }
  }

  Widget _buildMessageContainerWidget(Message message) {
    IconData iconData = message.isUser ? Icons.person : Icons.android;
    Color iconColor = message.isUser ? Colors.blue : Colors.green;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: message.isUser ? Colors.lightBlueAccent : Colors.greenAccent,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 2),
            blurRadius: 2.0,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(iconData, color: iconColor),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              message.text,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatListView() {
    return ListView.builder(
      itemCount: messages.length,
      controller: _scrollController,
      itemBuilder: (context, index) {
        if (index == messages.length - 1 && isBotTyping) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: _buildMessageContainerWidget(Message('Sedang mengetik...', false)),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: messages[index].isUser
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: _buildMessageContainerWidget(messages[index]),
            ),
          );
        }
      },
    );
  }

  Widget _buildTextComposer() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(24.0),
              ),
              child: TextField(
                onSubmitted: _handleSubmitted,
                controller: _textController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Type a message...',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                style: TextStyle(
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          SizedBox(width: 18),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
            child: IconButton(
              icon: Icon(Icons.send, color: Colors.white),
              onPressed: () {
                if (_textController.text.isNotEmpty) {
                  _handleSubmitted(_textController.text);
                  _textController.clear();
                }
              },
            ),
          ),
          SizedBox(width: 8),
          DropdownButton<String>(
            value: location,
            icon: Icon(Icons.location_on),
            onChanged: (String? newLocation) {
              if (newLocation != null) {
                changeLocation(newLocation);
              }
            },
            items: locations.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BOT13',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          AnimatedContainer(
            duration: Duration(seconds: 1),
            height: 50,
            child: Center(
              child: Text(
                "Welcome to BOT13",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey[200],
              child: _buildChatListView(),
            ),
          ),
          _buildTextComposer(),
        ],
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: ChatScreen(),
    ),
  );
}
