# BOT13
Welcome to the ChatBot application! This project includes a Flutter front-end and a integration rasa and Flask and Rasa back-end to create a chatbot.
byme: Panji Satria Taqwa Putra Purnama student  at Ahmad Dahlan University Yogyakarta

## Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Setup](#setup)
- [Usage](#usage)
- [Testing](#testing)
- [Contributing](#contributing)
- [License](#license)

## Overview

This application consists of a Flutter-based chat interface that communicates with a Flask server. The Flutter front-end allows users to send messages, and the Flask back-end processes these messages and generates appropriate responses.

## Features

- User-friendly chat interface.
- Integration with a Flask server to handle user messages and provide responses.
- Location-based features, such as weather information for a specified location.

## Setup

1. **Flutter Front-end:**
   - Ensure you have Flutter installed. If not, follow the instructions [here](https://flutter.dev/docs/get-started/install).
   - Navigate to the `flutter_chatbot` directory and run:
     ```bash
     flutter pub get
     flutter run
     ```

2. **Flask Back-end:**
   - Ensure you have Python installed (preferably Python 3).
   - Install the required Python packages:
     ```bash
     pip install Flask flask-cors
     ```
   - Navigate to the `flask_backend` directory and run:
     ```bash
     python app.py
     ```
3. **Rasa:**
   - Creating API server w rasa
   - Install the required Python packages:
     ```bash
     pip install rasa
     ```
     rasa init
     ```
     rasa train
     ```
   - Navigate to the `rasa server` directory and run:
     ```bash
     rasa run

## Usage

1. Open the Flutter app on your preferred device or emulator.
2. Type a message in the chat interface.
3. Press the send button to send the message.
4. Receive responses from the chatbot.

## Testing

- Unit tests for individual functions or components can be run using a testing framework like `unittest` or `pytest`. Example unit tests are provided in the `tests` directory.

- Integration tests for API endpoints can be conducted using tools like `Flask-Testing` or by writing custom test cases.

- End-to-End testing, especially for the Flutter front-end, can be performed using testing frameworks like `flutter_test` or tools like `Selenium` for web applications.

  ```bash
  # Example command for running Flutter end-to-end tests
  flutter test test/end_to_end_test.dart
  


# Images
![FORM](https://github.com/paslaframework/BOT13_mobileapps/raw/main/bot13_documentation/2.png)

## LICENSI

MIT License

Copyright (c) [2023] [Panji Satria Taqwa Putra Purnama]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.



