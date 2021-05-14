import 'package:flutter/material.dart';
import 'package:test_data_base/controller/form_controller.dart';
import 'package:test_data_base/model/form.dart';

class DatabaseScreenWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Feedback Responses',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: DatabasePageWeb(title: "Responses"));
  }
}

class DatabasePageWeb extends StatefulWidget {
  DatabasePageWeb({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DatabasePageWebState createState() => _DatabasePageWebState();
}

class _DatabasePageWebState extends State<DatabasePageWeb> {
  List<FeedbackForm> feedbackItems = List<FeedbackForm>();

  // Method to Submit Feedback and save it in Google Sheets

  @override
  void initState() {
    super.initState();

    FormController().getFeedbackList().then((feedbackItems) {
      setState(() {
        this.feedbackItems = feedbackItems;
      });
    });
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
            Icon(Icons.refresh),
            SizedBox(width: 4,),
            Text('Refresh database'),
          ],
        ),
        onPressed: () {
          FormController().getFeedbackList().then((feedbackItems) {
            setState(() {
              this.feedbackItems = feedbackItems;
            });
          });
        },
        tooltip: 'refresh database',
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
        child: ListView.builder(
          padding: EdgeInsets.only(top: 12.0, left: 2.0, right: 2.0, bottom: 5.0),
          itemCount: feedbackItems.length,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      feedbackItems[index].photo,
                    ),
                  ),
                  ListTile(
                    title: Row(
                      children: <Widget>[
                        //Icon(Icons.description),
                        Expanded(
                          child: Text(feedbackItems[index].name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24,),),
                        )
                      ],
                    ),
                    subtitle: Column(
                      children: [
                        Row(
                          children: <Widget>[
                            Icon(Icons.message, color: Colors.grey,),
                            SizedBox(width: 4,),
                            Text(feedbackItems[index].description),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.category, color: Colors.grey,),
                            SizedBox(width: 4,),
                            Text(feedbackItems[index].type),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.map, color: Colors.grey,),
                            SizedBox(width: 4,),
                            Text(feedbackItems[index].address),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        /*
        ListView(
            padding: EdgeInsets.only(top: 8.0, left: 2.0, right: 2.0, bottom: 5.0),
            children: <Widget>[]
        ),
        */
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
              Icon(Icons.apartment),
              SizedBox(width: 4,),
              Text("Database"),
            ],
          ),
        ),
      ),
    ]);
  }
}