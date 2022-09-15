import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class FireStorePage extends StatefulWidget {
  const FireStorePage({super.key});

  @override
  State<FireStorePage> createState() => _FireStorePageState();
}

class _FireStorePageState extends State<FireStorePage> {
  List<Map<String, dynamic>>? data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ElevatedButton(
              onPressed: () {
                final id = FirebaseAuth.instance.currentUser!.uid;
                final myDoc =
                    FirebaseFirestore.instance.collection("users").doc(id);
                myDoc.set({"aaa": "ok"});
              },
              child: Text("create")),
          ElevatedButton(
              onPressed: () async {
                final id = FirebaseAuth.instance.currentUser!.uid;
                final myDoc =
                    FirebaseFirestore.instance.collection("users").doc(id);
                final data = await myDoc.get();
                print(data.data());
              },
              child: Text("get")),
          ElevatedButton(
              onPressed: () async {
                final id = FirebaseAuth.instance.currentUser!.uid;
                final myDoc =
                    FirebaseFirestore.instance.collection("users").doc(id);
                final data = await myDoc.update({"name": "ali"});
              },
              child: Text("update")),
          ElevatedButton(
              onPressed: () async {
                final id = FirebaseAuth.instance.currentUser!.uid;
                final myDoc =
                    FirebaseFirestore.instance.collection("users").doc(id);
                final data = await myDoc.delete();
              },
              child: Text("delete")),
          ElevatedButton(
              onPressed: () async {
                final id = FirebaseAuth.instance.currentUser!.uid;
                final myDoc =
                    FirebaseFirestore.instance.collection("users").doc(id);
                final data = await myDoc.set({
                  "name": "create or update",
                }, SetOptions(merge: true));
              },
              child: Text("create or update")),

          ElevatedButton(
              onPressed: () async {
                final id = FirebaseAuth.instance.currentUser!.uid;
                final userCollection =
                    FirebaseFirestore.instance.collection("users");
                final users = await userCollection
                    .where("age", isGreaterThan: 50)
                    .where("isOk", isEqualTo: true)
                    .get();
                setState(() {
                  data = users.docs.map((e) => e.data()).toList();
                });
              },
              child: Text("get all data")),
          ElevatedButton(
              onPressed: () async {
                final id = FirebaseAuth.instance.currentUser!.uid;
                final userCollection =
                    FirebaseFirestore.instance.collection("users");
                userCollection.add({"hello": "ok"});
              },
              child: Text("add")),
          ElevatedButton(
              onPressed: () async {
                final id = FirebaseAuth.instance.currentUser!.uid;
                final userCollection =
                    FirebaseFirestore.instance.collection("users");
                final users =
                    await userCollection.orderBy("age", descending: true).get();

                setState(() {
                  data = users.docs.map((e) => e.data()).toList();
                });
              },
              child: Text("order by")),

          ElevatedButton(
              onPressed: () async {
                final id = FirebaseAuth.instance.currentUser!.uid;
                final userCollection =
                    FirebaseFirestore.instance.collection("users");
                final myDoc =
                    FirebaseFirestore.instance.collection("users").doc(id);
                final data = await myDoc.get();
                final users = await userCollection
                    .startAfterDocument(data)
                    .limit(5)
                    .get();
                for (var element in users.docs) {
                  print(element.data());
                }
              },
              child: Text("order by")),
          if (data != null)
            for (final item in data!) Text((item.toString()))
          // ElevatedButton(
          //     onPressed: () async {
          //       for (var i = 0; i < 30; i++) {
          //         final myDoc = FirebaseFirestore.instance
          //             .collection("users")
          //             .doc(i.toString());
          //         final data = await myDoc.set({
          //           "id": i,
          //           "isOk": Random().nextBool(),
          //           "age": Random().nextInt(100)
          //         });
          //       }
          //     },
          //     child: Text("create or update"))
        ],
      ),
    );
  }
}
