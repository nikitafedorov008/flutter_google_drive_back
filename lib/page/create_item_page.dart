import 'package:flutter/material.dart';
import 'package:test_data_base/controller/form_controller.dart';
import 'package:test_data_base/model/form.dart';

import 'database_page.dart';

class CreateItemPage extends StatefulWidget {

  @override
  _CreateItemPageState createState() => _CreateItemPageState();
}

class _CreateItemPageState extends State<CreateItemPage> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // TextField Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController photoController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  // Method to Submit Feedback and save it in Google Sheets
  void _submitForm() {
    // Validate returns true if the form is valid, or false
    // otherwise.
    if (_formKey.currentState.validate()) {
      // If the form is valid, proceed.
      FeedbackForm feedbackForm = FeedbackForm(
        nameController.text,
        descriptionController.text,
        typeController.text,
        photoController.text,
        addressController.text,
      );

      FormController formController = FormController();

      _showSnackbar("Submitting Feedback");

      // Submit 'feedbackForm' and save it in Google Sheets.
      formController.submitForm(feedbackForm, (String response) {
        print("Response: $response");
        if (response == FormController.STATUS_SUCCESS) {
          // Feedback is saved succesfully in Google Sheets.
          _showSnackbar("Feedback Submitted");
        } else {
          // Error Occurred while saving data in Google Sheets.
          _showSnackbar("Error Occurred!");
        }
      });
    }
  }

  // Method to show snackbar with 'message'.
  _showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Add new place'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        controller: nameController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Valid Name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'Name'),
                      ),
                      TextFormField(
                        controller: descriptionController,
                        /*validator: (value) {
                          if (!value.contains("@")) {
                            return 'Enter Valid Description';
                          }
                          return null;
                        },*/
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(labelText: 'Description'),
                      ),
                      TextFormField(
                        controller: typeController,
                        /*validator: (value) {
                          if (value.trim().length != 10) {
                            return 'Enter Type';
                          }
                          return null;
                        },*/
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Type',
                        ),
                      ),
                      TextFormField(
                        controller: photoController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter Photo URL';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(labelText: 'Photo'),
                      ),
                      TextFormField(
                        controller: addressController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Address';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(labelText: 'Address'),
                      ),
                    ],
                  ),
                )),
            RaisedButton(
              color: Colors.red,
              textColor: Colors.white,
              onPressed: _submitForm,
              child: Text('Add place'),
            ),
          ],
        ),
      ),
    );
  }
}