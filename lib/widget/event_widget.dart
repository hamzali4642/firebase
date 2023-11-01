import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/model/event_model.dart';
import 'package:firebase/screens/dashboard/add_event.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventWidget extends StatelessWidget {
  const EventWidget({Key? key, required this.event}) : super(key: key);

  final EventModel event;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                    ),
                    Text(
                      DateFormat("MMM dd,yyyy").format(
                          DateTime.fromMillisecondsSinceEpoch(event.date)),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => AddEvent(
                            event: event,
                          )));
                },
                icon: Icon(
                  Icons.edit,
                ),
              ),
              IconButton(
                onPressed: () {
                  FirebaseFirestore.instance.collection("events").doc(event.id).delete();
                },
                icon: Icon(
                  Icons.delete,
                ),
              ),
            ],
          ),
          Image(
            image: NetworkImage(event.image),
          ),
        ],
      ),
    );
  }
}
