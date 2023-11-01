import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/screens/dashboard/add_event.dart';
import 'package:firebase/widget/event_widget.dart';
import 'package:flutter/material.dart';

import '../../model/event_model.dart';

class Events extends StatefulWidget {
  const Events({Key? key}) : super(key: key);

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  List<EventModel> events = [];

  getData() {
    FirebaseFirestore.instance.collection("events").snapshots().listen((event) {
      var docs = event.docs;
      events = List.generate(
          docs.length, (index) => EventModel.fromMap(docs[index].data()));

      setState(() {});
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => AddEvent()));
        },
        child: Icon(
          Icons.add,
        ),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, i) {
          return EventWidget(event: events[i]);
        },
        itemCount: events.length,
      ),
    );
  }
}
