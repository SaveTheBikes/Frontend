import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/reqs.dart';
import 'package:image_picker/image_picker.dart';

class ReportBikeDialog extends StatefulWidget {
  @override
  _ReportBikeDialogState createState() => _ReportBikeDialogState();
}

class _ReportBikeDialogState extends State<ReportBikeDialog> {
  File? image;
  DateTime? selectedDate;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController makeController = TextEditingController();
  final TextEditingController colourController = TextEditingController();



  Future _getImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      }
    });
  }

  Future _pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
    scrollable:true,
    title: Text("Report a Missing Bike"),
      // ... (rest of the code remains the same)

      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ... (existing form fields)
TextField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'Name',
            ),
          ),
TextField(
            controller: makeController,
            decoration: const InputDecoration(
              labelText: 'Model',
            ),
          ),
TextField(
            controller: colourController,
            decoration: const InputDecoration(
              labelText: 'Colour',
            ),
          ),




          SizedBox(height: 16),
          ElevatedButton(
            onPressed: _pickDate,
            child: Text('Pick Date'),
          ),
          selectedDate != null
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    '${selectedDate!.toLocal().toString().split(" ")[0]}',
                    style: TextStyle(fontSize: 16),
                  ),
                )
              : Container(),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: _getImage,
            child: Text('Upload Image'),
          ),
          image != null
              ? Container(
                  margin: EdgeInsets.only(top: 8),
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: FileImage(image!),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Container(),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Handle the form submission logic here, including the image and date
              // You can access the entered data, image, and date using controllers or state
              // Example:
              print('Form submitted with image: $image, date: $selectedDate');
              report_bike(titleController.text,makeController.text,colourController.text,selectedDate!,image!).then((value) {if(value){Navigator.pop(context);}});
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}

