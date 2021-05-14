import 'package:flutter/material.dart';
import 'package:test_data_base/controller/form_controller.dart';
import 'package:test_data_base/model/form.dart';

import 'database_page.dart';

class CreateItemPageWeb extends StatefulWidget {
  CreateItemPageWeb({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CreateItemPageWebState createState() => _CreateItemPageWebState();
}

class _CreateItemPageWebState extends State<CreateItemPageWeb> {
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

      //_showSnackbar("Submitting Feedback");

      // Submit 'feedbackForm' and save it in Google Sheets.
      formController.submitForm(feedbackForm, (String response) {
        print("Response: $response");
        if (response == FormController.STATUS_SUCCESS) {
          // Feedback is saved succesfully in Google Sheets.
          //_showSnackbar("Feedback Submitted");
        } else {
          // Error Occurred while saving data in Google Sheets.
          //_showSnackbar("Error Occurred!");
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
      body: setUserForm(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_location_rounded),
            SizedBox(width: 4,),
            Text('Add place'),
          ],
        ),
        onPressed: _submitForm,
        tooltip: 'Add place',
      ),
    );
  }

  double _cardSize() {
    if (MediaQuery.of(context).size.height > MediaQuery.of(context).size.width) {
      return 100.0;
    }  else {
      return 60.0;
    }
  }

  @override
  void initState() {
    super.initState();
//    download();
  }

  Widget setUserForm() {
    return Stack(children: <Widget>[
      // Background with gradient
      Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomLeft,
                  colors: [Colors.red[900], Colors.redAccent[100]])),
          height: MediaQuery.of(context).size.height * 0.4
      ),
      //Above card
      Card(
          elevation: 20.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          margin: EdgeInsets.only(left: 15.0, right: 15.0, top: _cardSize()),
          child: ListView(
              padding:
              EdgeInsets.only(top: 8.0, left: 2.0, right: 2.0, bottom: 5.0),
              children: <Widget>[
                Column(
                  children: [
                    Form(
                        key: _formKey,
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: nameController,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Enter Valid Name';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      borderSide: new BorderSide(color: Colors.greenAccent),
                                    ),
                                    labelText: 'Name',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: descriptionController,
                                  /*validator: (value) {
                          if (!value.contains("@")) {
                            return 'Enter Valid Description';
                          }
                          return null;
                        },*/
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    border: new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      borderSide: new BorderSide(color: Colors.greenAccent),
                                    ),
                                    labelText: 'Description',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: typeController,
                                  /*validator: (value) {
                          if (value.trim().length != 10) {
                            return 'Enter Type';
                          }
                          return null;
                        },*/
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      borderSide: new BorderSide(color: Colors.greenAccent),
                                    ),
                                    labelText: 'Type',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: photoController,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Enter Photo URL';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                    border: new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      borderSide: new BorderSide(color: Colors.greenAccent),
                                    ),
                                    labelText: 'Photo URL',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: addressController,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Address';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                    border: new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      borderSide: new BorderSide(color: Colors.greenAccent),
                                    ),
                                    labelText: 'Address',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                    Text('https://docs.google.com/spreadsheets/d/1FKbExZP0_uFriyq8c4IJ-MgOlPDiwuOV1oDN6dAFwpc/edit?usp=sharing'),
                  ],
                ),
              ]
          ),
      ),
      //positioned to take only AppBar size
      Positioned(
        top: 0.0,
        left: 0.0,
        right: 0.0,
        child: AppBar(
          //add AppBar here only
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_location_alt_rounded),
              SizedBox(width: 4,),
              Text("Add new place"),
            ],
          ),
        ),
      ),
    ]);
  }
}