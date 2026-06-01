// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'custom_morphism.dart';
import 'fire_store.dart';

class StaffList extends StatefulWidget {
  const StaffList({super.key});

  @override
  State<StaffList> createState() => _StaffListState();
}

class _StaffListState extends State<StaffList> {
  Firestoreservics fire = Firestoreservics();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color.fromARGB(255, 59, 81, 209),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Staff List",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Theme.of(context).colorScheme.primary),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).colorScheme.primary,
            )),
      ),
      body: Stack(
        children: [
          // Lottie.asset(
          //   "lib/image/Background_lottie_2.json",
          //   width: MediaQuery.of(context).size.width,
          //   height: MediaQuery.of(context).size.height,
          //   fit: BoxFit.fill,
          // ),

          // actions: [
          //   IconButton(
          //       onPressed: () {
          //         showSearch(
          //           context: context,
          //           delegate: CustomShowDelegate(),
          //         );
          //       },
          //       icon: const Icon(
          //         Icons.search,
          //         color: Colors.black,
          //       ))
          // ],
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 0),
              child: CustomMorphisum(
                  radius: 20,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: fire.getNotes(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          if (snapshot.hasData) {
                            List notelist = snapshot.data!.docs;
                            if (notelist.isNotEmpty) {
                              return ListView.builder(
                                itemCount: notelist.length,
                                itemBuilder: (context, index) {
                                  DocumentSnapshot document = notelist[index];
                                  return Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20.0, 8, 20, 8),
                                    child: CustomMorphisum(
                                      radius: 20,
                                      width: MediaQuery.of(context).size.width,
                                      height: 70,
                                      child: ListTile(
                                        contentPadding: EdgeInsets.all(5),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        leading: Icon(Icons.person,
                                            size: 30,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary),
                                        title: Text(
                                          "${document["firstname"]}",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                        ),
                                        subtitle: Text(
                                          "${document["subject"]}",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                        ),
                                        trailing: IconButton(
                                            onPressed: () {
                                              _bottompopup(context, document);
                                            },
                                            icon: Icon(
                                              Icons.arrow_circle_right_outlined,
                                              size: 40,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            )),
                                      ),
                                    ),
                                  );
                                },
                              ).animate().fade(delay: 350.ms).slideY(
                                  delay: 0.milliseconds,
                                  duration: 2.seconds,
                                  curve: Curves.fastOutSlowIn,
                                  begin: 1,
                                  end: 0);
                            } else {
                              return Center(
                                child: Text(
                                  "NO DATA FOUND",
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                              );
                            }
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text("${snapshot.hasError.toString()} "),
                            );
                          } else {
                            return Center(
                              child: Text(
                                "NO DATA FOUND",
                                style: TextStyle(
                                    fontSize: 25,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                            );
                          }
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      })),
            ),
          ),
        ],
      ),
    );
  }

  void _bottompopup(context, document) {
    var time = DateTime.now();
    showModalBottomSheet(
        context: context,
        builder: (context) => CustomMorphisum(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width,
              radius: 20,
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2,
                          ))),
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Text(
                                "${document["firstname"]}",
                                style: TextStyle(
                                  fontSize: 23,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.clear_rounded,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ))
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left:10),
                          child: DefaultTextStyle(
                            style: TextStyle(
                            fontFamily: 'Platypi',
                             fontSize: 20,
                             color: Theme.of(context).colorScheme.primary,
                               ),
                          child: Table(
                          
                                columnWidths: {
                                0: IntrinsicColumnWidth(),
                                  1: FlexColumnWidth(),
                                      },
                                 children: [
                                    TableRow(children: [
                                    Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
                                    Text(': ${document["firstname"]} ${document["lastname"]}',
                                     style: TextStyle(fontWeight: FontWeight.normal)),
                                     ]),
                          
                                    TableRow(children: [
                                    Text('Subject', style: TextStyle(fontWeight: FontWeight.bold)),
                                     Text(': ${document["subject"]}', style: TextStyle(fontWeight: FontWeight.normal)),
                                     ]),
                          
                                     TableRow(children: [
                                         Text('Age', style: TextStyle(fontWeight: FontWeight.bold)),
                                        Text(': ${time.year - int.parse(document["year"])}', style: TextStyle(fontWeight: FontWeight.normal)),
                                       ]),
                          
                                      TableRow(children: [
                                           Text('Sex', style: TextStyle(fontWeight: FontWeight.bold)),
                                           Row(
                                           children: [
                                          Text(': ${document["sex"]}', style: TextStyle(fontWeight: FontWeight.normal)),
                                          _showSex(document),
                                        ],
                                           ),
                                         ]),
                          
                                      TableRow(children: [
                                        Text('Education', style: TextStyle(fontWeight: FontWeight.bold)),
                                         Text(': ${document["edu"]}', style: TextStyle(fontWeight: FontWeight.normal)),
                                           ]),
                          
                                      TableRow(children: [
                                         Text('Experience', style: TextStyle(fontWeight: FontWeight.bold)),
                                           Text(': ${document["experience"]}', style: TextStyle(fontWeight: FontWeight.normal)),
                                          ]),
                          
                                      TableRow(children: [
                                         Text('Mobile Number', style: TextStyle(fontWeight: FontWeight.bold)),
                                         Text(': ${document["mobile"]}', style: TextStyle(fontWeight: FontWeight.normal)),
                                        ]),
                          
                                      TableRow(children: [
                                        Text('Email', style: TextStyle(fontWeight: FontWeight.bold)),
                                        Text(': ${document["email"]}', style: TextStyle(fontWeight: FontWeight.normal)),
                                        ]),
                                      TableRow(children: [
                                           Text('Address', style: TextStyle(fontWeight: FontWeight.bold)),
                                            Text(': ${document["address"]}', style: TextStyle(fontWeight: FontWeight.normal)),
                                      ]),
                                      ],
                                      ),
                                                ),
                        ),

                        
                      
                    ],
                  ),
                ],
              ),
            ));
  }

  Widget _showSex(document) {
    if ("${document["sex"]}" == "Male") {
      return Icon(
        Icons.male,
        color: Colors.blue[600],
      );
    } else if ("${document["sex"]}" == "Female") {
      return Icon(Icons.female, color: Colors.pink[300]);
    } else {
      return Icon(Icons.transgender);
    }
  }
}

