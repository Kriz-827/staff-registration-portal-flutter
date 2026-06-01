// ignore_for_file: sort_child_properties_last

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:staff_reg_portal/fire_store.dart';
import 'package:staff_reg_portal/profile_list.dart';
import 'package:staff_reg_portal/themes/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'custom_morphism.dart';
import 'registration_form.dart';
import 'staff_list.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  bool isDrawerSelected = false;
  // ignore: non_constant_identifier_names
  CarouselController carouselController = CarouselController();
  final _advancedDrawerController = AdvancedDrawerController();
  @override
  void initState() {
    super.initState();
  }

  void _handleMenuButtonPressed() {
    setState(() {
      isDrawerSelected = !isDrawerSelected;
    });
  }

  Firestoreservics fire = Firestoreservics();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // final themeState = Provider.of<ThemeProvider>(context);
    return AdvancedDrawer(
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      drawer: DrawerNav(),
      // backdrop: Container(
      //   width: double.infinity,
      //   height: double.infinity,
      //   decoration:
      //       BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
      // ),
      openRatio: 0.65,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      controller: _advancedDrawerController,
      child: Scaffold(
        key: scaffoldKey,
        extendBodyBehindAppBar: true,
        body: Stack(children: [
          Center(
            child: ListView(
              children: [
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40.0, 0, 40, 0),
                  child: CustomMorphisum(
                    height: 200,
                    radius: 70,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Center(
                      child: Text(
                        "Hello !!\nGet Started",
                        style: TextStyle(
                          fontFamily: "Platypi",
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          backgroundColor: Colors.transparent,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(80.0, 0, 80, 0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegistrationForm(),
                          ));
                    },
                    child: CustomMorphisum(
                      height: 70,
                      radius: 20,
                      width: 200,
                      child: Center(
                        child: Text(
                          "New Registration",
                          style: TextStyle(
                            fontFamily: "Platypi",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 17,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StaffList(),
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(80.0, 0, 80, 0),
                    child: CustomMorphisum(
                        radius: 20,
                        child: Center(
                          child: Text(
                            "Staff List",
                            style: TextStyle(
                              fontFamily: "Platypi",
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        width: 300,
                        height: 70),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 20, 10, 10),
                  child: Center(
                    child: Text(
                      "Latest Registered Staff",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: fire.getNotes(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        if (snapshot.hasData &&
                            snapshot.data!.docs.length > 1) {
                          List notelist = snapshot.data!.docs;
                          return CarouselSlider.builder(
                              itemCount: notelist.length,
                              itemBuilder: (context, index, __) {
                                DocumentSnapshot document = notelist[index];
                                return Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiary,
                                            offset: const Offset(-4, -4),
                                            blurRadius: 10,
                                            spreadRadius: 1),
                                        BoxShadow(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            offset: const Offset(4, 4),
                                            blurRadius: 10,
                                            spreadRadius: 1)
                                      ],
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(30)),
                                      gradient: LinearGradient(
                                          colors: [
                                            Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            Theme.of(context)
                                                .colorScheme
                                                .secondary
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight),
                                    ),
                                    width: MediaQuery.of(context).size.width *
                                        0.65,
                                    height: 70,
                                    child: Center(
                                      child: GestureDetector(
                                        onDoubleTap: () {
                                          _popup_details(context, document);
                                        },
                                        child: Text(
                                          "${document["firstname"]} ${document["lastname"]}",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              options: CarouselOptions(
                                height: 70,
                                enlargeCenterPage: true,
                                enlargeFactor: 0.4,
                                autoPlay: true,
                                enableInfiniteScroll: true,
                                autoPlayInterval: const Duration(seconds: 3),
                                autoPlayAnimationDuration:
                                    const Duration(milliseconds: 800),
                              ));
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text("${snapshot.hasError.toString()} "),
                          );
                        } else {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 70,
                            child: const Center(
                              child: Text("NO DATA FOUND"),
                            ),
                          );
                        }
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ]),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(top: 10, left: 5),
          child: FloatingActionButton(
            foregroundColor: Theme.of(context).colorScheme.secondary,
            onPressed: () {
              _handleMenuButtonPressed;
              _advancedDrawerController.showDrawer();
            },
            tooltip: 'Drawer',
            child: isDrawerSelected
                ? Icon(
                    Icons.clear,
                    color: Theme.of(context).colorScheme.primary,
                  )
                : Icon(
                    Icons.menu,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            backgroundColor: Theme.of(context).colorScheme.secondary,
            splashColor: Colors.brown[100],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Future<AwesomeDialog> _popup_details(context, document) async {
    return await AwesomeDialog(
      dialogBackgroundColor: Theme.of(context).colorScheme.secondary,
      context: context,
      dialogType: DialogType.noHeader,
      width: MediaQuery.of(context).size.width * 0.8,
      buttonsBorderRadius: const BorderRadius.all(Radius.circular(30)),
      dismissOnTouchOutside: true,
      animType: AnimType.bottomSlide,
      desc:
          "Name:${document["firstname"]} ${document["lastname"]}\nSubject:${document["subject"]}\nEducation:${document["edu"]}",
      autoDismiss: true,
      descTextStyle:
          TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 18),
      autoHide: const Duration(seconds: 4),
    ).show();
  }

  SafeArea DrawerNav() {
    final themeState = Provider.of<ThemeProvider>(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                CustomMorphisum(
                  radius: 30,
                  height: 160,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.person,
                        size: 70,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8),
                          child: _userDetail())
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  height: 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  width: MediaQuery.of(context).size.width * 0.8,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomMorphisum(
                  radius: 30,
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    leading: Icon(
                      Icons.home,
                      size: 30,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    title: Text(
                      "Home",
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    onTap: () => _advancedDrawerController.toggleDrawer(),
                  ),
                ).animate().fade(delay: 500.ms).slideX(
                    delay: 0.milliseconds,
                    duration: 2.seconds,
                    curve: Curves.fastOutSlowIn,
                    begin: 1,
                    end: 0),
                const SizedBox(
                  height: 15,
                ),
                CustomMorphisum(
                  radius: 30,
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: ListTile(
                      contentPadding: const EdgeInsets.all(5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      leading: Icon(
                        Icons.person,
                        size: 30,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: Text(
                        "Profile",
                        style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      onTap: () {
                        _advancedDrawerController.hideDrawer();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProfileList()));
                      }),
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomMorphisum(
                  radius: 20,
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: SwitchListTile(
                    thumbColor: WidgetStatePropertyAll(
                        Theme.of(context).colorScheme.tertiary),
                    tileColor: Colors.transparent,
                    value: themeState.getthemedata,
                    contentPadding: const EdgeInsets.all(5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    title: Text(
                      "Theme",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    secondary: Icon(
                      themeState.getthemedata
                          ? Icons.dark_mode_outlined
                          : Icons.light_mode,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onChanged: (value) {
                      themeState.themedata = value;
                    },
                  ),
                ),
              ],
            ),
            const Spacer(),
            CustomMorphisum(
              radius: 20,
              width: MediaQuery.of(context).size.width,
              height: 70,
              child: SlideAction(
                borderRadius: 17,
                elevation: 0,
                innerColor: Theme.of(context).colorScheme.secondary,
                outerColor: Theme.of(context).colorScheme.tertiary,
                sliderButtonIcon: const Icon(Icons.logout),
                text: "  Slide to Log-Out",
                textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary),
                onSubmit: () {
                  FirebaseAuth.instance.signOut();
                  return;
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _userDetail() {
    late final FirebaseAuth _stream = FirebaseAuth.instance;
    final User? user = _stream.currentUser;
    if (user != null) {
      return Text(
        "${user.email}",
        style: TextStyle(
            fontSize: 20, color: Theme.of(context).colorScheme.primary),
      );
    }
    return const CircularProgressIndicator(
      color: Colors.lightBlue,
    );
  }
}
