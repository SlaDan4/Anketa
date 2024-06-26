import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(
  MaterialApp(
    home: AnketaPage(),
  ),
);

class AnketaPage extends StatefulWidget {
  @override
  _AnketaPageState createState() => _AnketaPageState();
}

class _AnketaPageState extends State<AnketaPage> {
  final List<String> childrenHomes = [
    'Дом №1',
    'Дом №2',
    'Дом №3',
    'Дом №4',
    'Дом №5',
  ];

  String? selectedHome;
  TextEditingController clothingController = TextEditingController();
  TextEditingController stationeryController = TextEditingController();
  TextEditingController hygieneController = TextEditingController();
  TextEditingController toysController = TextEditingController();
  TextEditingController textbooksController = TextEditingController();

  @override
  void dispose() {
    clothingController.dispose();
    stationeryController.dispose();
    hygieneController.dispose();
    toysController.dispose();
    textbooksController.dispose();
    super.dispose();
  }

  Future<void> submitSurvey() async {
    final url = Uri.parse('http://127.0.0.1:5000/submit');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'children_home': selectedHome,
        'clothing': int.parse(clothingController.text),
        'stationery': int.parse(stationeryController.text),
        'hygiene': int.parse(hygieneController.text),
        'toys': int.parse(toysController.text),
        'textbooks': int.parse(textbooksController.text),
      }),
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Данные отправлены!'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ошибка отправки данных!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.green.shade900,
              Colors.green.shade700,
              Colors.green.shade400,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Анкета',
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Присвойте каждой необходимости оценку по тому, насколько она вам нужна от 1 до 5 (где 5 - самое необходимое). \nКаждую оценку используйте только один раз.',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          hintText: "Как называется ваш детский дом?",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        value: selectedHome,
                        items: childrenHomes.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            selectedHome = value;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(27, 225, 95, 0.3),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: clothingController,
                          decoration: InputDecoration(
                            hintText: "Одежда",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(27, 225, 95, 0.3),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: stationeryController,
                          decoration: InputDecoration(
                            hintText: "Канцелярия",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(27, 225, 95, 0.3),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: hygieneController,
                          decoration: InputDecoration(
                            hintText: "Средства личной гигиены",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(27, 225, 95, 0.3),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: toysController,
                          decoration: InputDecoration(
                            hintText: "Игрушки",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(27, 225, 95, 0.3),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: textbooksController,
                          decoration: InputDecoration(
                            hintText: "Учебники",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          List<String> validValues = ['1', '2', '3', '4', '5'];
          String clothingValue = clothingController.text;
          String stationeryValue = stationeryController.text;
          String hygieneValue = hygieneController.text;
          String toysValue = toysController.text;
          String textbooksValue = textbooksController.text;

          bool allValuesAreValid = validValues.contains(clothingValue) &&
              validValues.contains(stationeryValue) &&
              validValues.contains(hygieneValue) &&
              validValues.contains(toysValue) &&
              validValues.contains(textbooksValue);

          bool allValuesAreUnique = clothingValue != stationeryValue &&
              clothingValue != hygieneValue &&
              clothingValue != toysValue &&
              clothingValue != textbooksValue &&
              stationeryValue != hygieneValue &&
              stationeryValue != toysValue &&
              stationeryValue != textbooksValue &&
              hygieneValue != toysValue &&
              hygieneValue != textbooksValue &&
              toysValue != textbooksValue;

          if (allValuesAreValid && allValuesAreUnique && selectedHome != null) {
            submitSurvey();

            setState(() {
              selectedHome = null;
              clothingController.text = "";
              stationeryController.text = "";
              hygieneController.text = "";
              toysController.text = "";
              textbooksController.text = "";
            });

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Данные отправлены!'),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Анкета заполнена неправильно!'),
              ),
            );
          }
        },
        child: Icon(Icons.send),
        backgroundColor: Colors.green.shade800,
      ),
    );
  }
}
