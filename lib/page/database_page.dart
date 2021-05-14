import 'package:flutter/material.dart';
import 'package:test_data_base/controller/form_controller.dart';
import 'package:test_data_base/model/form.dart';
import 'package:test_data_base/page/create_item_page.dart';
import 'package:test_data_base/page/create_item_page_web.dart';

class DatabaseMobileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Places',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: DatabasePageMobile(title: "Places"));
  }
}

class DatabasePageMobile extends StatefulWidget {
  DatabasePageMobile({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DatabasePageMobileState createState() => _DatabasePageMobileState();
}

class _DatabasePageMobileState extends State<DatabasePageMobile> {
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
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateItemPage(),
                  )
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: Row(
          children: [
            Icon(Icons.refresh),
            SizedBox(width: 4,),
            Text('Refresh database')
          ],
        ),
        onPressed: () {
          FormController().getFeedbackList().then((feedbackItems) {
            setState(() {
              this.feedbackItems = feedbackItems;
            });
          });
        },
      ),
    );
  }
}