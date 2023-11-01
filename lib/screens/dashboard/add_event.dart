import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/model/event_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({Key? key, this.event}) : super(key: key);

  final EventModel? event;

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  var title = TextEditingController();
  var image = TextEditingController();

  DateTime date = DateTime.now();

  @override
  void initState() {
    if (widget.event != null) {
      title.text = widget.event!.title;
      image.text = widget.event!.image;
      date = DateTime.fromMillisecondsSinceEpoch(widget.event!.date);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${widget.event == null ? "Add Event" : "Update Event"}"),
            TextField(
              controller: title,
              decoration: InputDecoration(hintText: "Title"),
            ),
            Gap(10),
            TextField(
              controller: image,
              decoration: InputDecoration(hintText: "Image"),
            ),
            Gap(10),
            InkWell(
              onTap: () async {
                var d = await getDate();
                if (d != null) {
                  date = d;
                  setState(() {});
                }
              },
              child: Text(
                DateFormat("MMM dd, yyyy").format(date),
              ),
            ),
            Gap(10),
            ElevatedButton(
              onPressed: () async {
                var doc = FirebaseFirestore.instance.collection("events").doc(widget.event?.id);

                var event = EventModel(
                    id: doc.id,
                    title: title.text,
                    image: image.text,
                    date: date.millisecondsSinceEpoch);

                await doc.set(event.toMap());

                Navigator.of(context).pop();
              },
              child: Text("Save"),
            )
          ],
        ),
      ),
    );
  }

  Future<DateTime?> getDate() {
    // Imagine that this function is
    // more complex and slow.
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate:  DateTime.now(),
      lastDate: DateTime(2030),
    );
  }
}
