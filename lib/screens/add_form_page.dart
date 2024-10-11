import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sas_flutter/screens/display_page.dart';
import 'dart:convert';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<FormPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phnoController = TextEditingController();
  TextEditingController emgnameController = TextEditingController();
  TextEditingController emgphnoController = TextEditingController();
  TextEditingController emgrelationController = TextEditingController();
  TextEditingController bloodgroupController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Add Your Information',
            style: TextStyle(
              fontWeight: FontWeight.bold, // Makes the text bold
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(
            255, 120, 190, 247), // Sets the AppBar color to blue
      ),
      body: ListView(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(hintText: '   Name'),
          ),
          SizedBox(height: 10), //Spacing between input boxes

          TextField(
            controller: ageController,
            decoration: InputDecoration(hintText: '   Age'),
          ),
          SizedBox(height: 10),

          TextField(
            controller: phnoController,
            decoration: InputDecoration(hintText: '   Phone Number'),
          ),
          SizedBox(height: 10),

          TextField(
            controller: addressController,
            decoration: InputDecoration(hintText: '  Address'),
            keyboardType: TextInputType.multiline,
            minLines: 2,
            maxLines: 8,
          ),
          SizedBox(height: 10),

          TextField(
            controller: emgnameController,
            decoration: InputDecoration(hintText: '   Emergency Contact Name'),
          ),
          SizedBox(height: 10),

          TextField(
            controller: emgrelationController,
            decoration:
                InputDecoration(hintText: '   Emergency Contact Relation'),
          ),
          SizedBox(height: 10),

          TextField(
            controller: emgphnoController,
            decoration: InputDecoration(hintText: '   Emergency phone number'),
          ),
          SizedBox(height: 10),

          TextField(
            controller: bloodgroupController,
            decoration: InputDecoration(hintText: '   Blood Group'),
          ),
          SizedBox(height: 10),

          ElevatedButton(
            onPressed: sumbitData,
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }

  Future<void> sumbitData() async {
    //Get data from form
    final id = 1;
    final name = nameController.text;
    final age = int.tryParse(ageController.text);
    final phno = phnoController.text;
    final add = addressController.text;
    final ecn = emgnameController.text;
    final ecr = emgrelationController.text;
    final ecno = emgphnoController.text;
    final bg = bloodgroupController.text;
    final body = {
      "id": id,
      "name": name,
      "age": age,
      "phone-number": phno,
      "address": add,
      "emg-contact-name": ecn,
      "emg-contact-relation": ecr,
      "emg-contact-phno": ecno,
      "blood-grp": bg,
    };

    //Submit data to the server
    final url = 'http://172.17.99.78:3000/items';
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );

    //Show Success or failure
    if (response.statusCode == 201) {
      print('Successfully created');
      showSuccessMessage('Successfully created');

      //Go back to home page
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => DisplayPage()),
        (Route<dynamic> route) => false,
      );
    } else {
      showErrorMessage('Error-Creation Failed');
      print('Error-Creation Failed');
      print(response.body);
    }
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message,
          style: const TextStyle(
            fontWeight: FontWeight.bold, // Makes the text bold
            color: Colors.white,
          )),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message,
          style: const TextStyle(
            fontWeight: FontWeight.bold, // Makes the text bold
            color: Colors.white,
          )),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}