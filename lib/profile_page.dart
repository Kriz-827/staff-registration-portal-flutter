import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'custom_morphism.dart';
import 'profile_box.dart';

// ignore: must_be_immutable
class ProfilePage extends StatefulWidget {
  DocumentSnapshot document;
  ProfilePage({super.key, required this.document});

  @override
  // ignore: no_logic_in_create_state
  State<ProfilePage> createState() => _ProfilePageState(document);
}

class _ProfilePageState extends State<ProfilePage> {
  DocumentSnapshot document;
  _ProfilePageState(this.document);
  User? user;
  var time = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.secondary,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Profile",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Theme.of(context).colorScheme.primary),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back,
                color: Theme.of(context).colorScheme.primary)),
        actions: [
          IconButton(
              onPressed: () {
                _popup(context);
              },
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).colorScheme.primary,
                size: 30,
              ))
        ],
      ),
      body: Stack(
        children: [
          // Lottie.asset(
          //   "lib/image/Background_lottie_2.json",
          //   width: MediaQuery.of(context).size.width * 1.25,
          //   height: MediaQuery.of(context).size.width * 1.45,
          //   fit: BoxFit.fill,
          // ),
          Center(
            child: CustomMorphisum(
                radius: 20,
                width: MediaQuery.of(context).size.width * 0.95,
                height: MediaQuery.of(context).size.height * 0.85,
                child: Myprofile(document.data() as Map<String, dynamic>)),
          )
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  ListView Myprofile(document) {
    return ListView(children: [
      Icon(
        Icons.person,
        color: Theme.of(context).colorScheme.primary,
        size: 70,
      ),
      ProfileBox(
        mainText: "First Name",
        onPressed: () {
          editProfile("firstname");
        },
        subText: "${document["firstname"]}",
      ),
      ProfileBox(
        mainText: "Last Name",
        onPressed: () {
          editProfile("lastname");
        },
        subText: "${document["lastname"]}",
      ),
      ProfileBox(
        mainText: "Current Address",
        onPressed: () {
          editProfile("address");
        },
        subText: "${document["address"]}",
      ),
      // ProfileBox(
      //   mainText: "Subject Learned",
      //   onPressed: () {
      //     editProfile("subject");
      //   },
      //   subText: "${document["subject"]}",
      // ),
      ProfileBox(
        mainText: "College",
        onPressed: () {
          editProfile("college");
        },
        subText: "${document["college"]}",
      ),
      // ProfileBox(
      //   mainText: "Experience",
      //   onPressed: () {
      //     editProfile("experience");
      //   },
      //   subText: "${document["experience"]}",
      // ),
      ProfileBox(
        mainText: "Mobile Number",
        onPressed: () {
          editProfile("mobile");
        },
        subText: "${document["mobile"]}",
      ),
      ProfileBox(
        mainText: "Education",
        onPressed: () {
          editProfile("edu");
        },
        subText: "${document["edu"]}",
      ),
    ]);
  }

  Future<void> editProfile(String field) async {
    String newValue = "";
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              title: Text(
                "Edit $field",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              content: TextField(
                autofocus: true,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
                decoration: InputDecoration(
                    hintText: "Enter new $field",
                    hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primary)),
                onChanged: (value) {
                  newValue = value;
                },
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel")),
                TextButton(
                    onPressed: () => Navigator.of(context).pop(newValue),
                    child: const Text("Save")),
              ],
            ));

    // ignore: prefer_is_empty
    if (newValue.trim().length > 0) {
      await FirebaseFirestore.instance
          .collection('Details')
          .doc(document.id)
          .update({field: newValue});
      DocumentSnapshot newdocument = await FirebaseFirestore.instance
          .collection('Details')
          .doc(document.id)
          .get();

      setState(() {
        document = newdocument;
      });
    }
  }

  Future<AwesomeDialog> _popup(context) async {
    return await AwesomeDialog(
        dialogBackgroundColor: Theme.of(context).colorScheme.secondary,
        context: context,
        dialogType: DialogType.warning,
        btnOkColor: Theme.of(context).colorScheme.primary,
        buttonsTextStyle:
            TextStyle(color: Theme.of(context).colorScheme.secondary),
        width: MediaQuery.of(context).size.width * 0.8,
        buttonsBorderRadius: const BorderRadius.all(Radius.circular(30)),
        dismissOnTouchOutside: true,
        animType: AnimType.bottomSlide,
        desc: "Confirm to Delete",
        descTextStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary, fontSize: 20),
        showCloseIcon: true,
        btnOkOnPress: () {
          FirebaseFirestore.instance
              .collection("Details")
              .doc(document.id)
              .delete();
          int count = 0;
          Navigator.of(context).popUntil((_) => count++ >= 2);
        }).show();
  }
}
