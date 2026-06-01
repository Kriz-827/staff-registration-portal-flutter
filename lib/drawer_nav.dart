// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:slide_to_act/slide_to_act.dart';

// import 'package:staff_reg_portal/themes/theme_provider.dart';
// import 'package:provider/provider.dart';
// import 'custom_morphism.dart';
// import 'profile_list.dart';

// class DrawerNav extends StatefulWidget {
//   const DrawerNav({super.key});

//   @override
//   State<DrawerNav> createState() => _DrawerNavState();
// }

// class _DrawerNavState extends State<DrawerNav> {
//   late final FirebaseAuth _stream = FirebaseAuth.instance;

//   Widget _userDetail() {
//     final User? user = _stream.currentUser;
//     if (user != null) {
//       return Text(
//         "${user.email}",
//         style: TextStyle(
//             fontSize: 20, color: Theme.of(context).colorScheme.primary),
//       );
//     }
//     return const CircularProgressIndicator(
//       color: Colors.lightBlue,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final themeState = Provider.of<ThemeProvider>(context);
//     return Drawer(
//       backgroundColor: Theme.of(context).colorScheme.secondary,
//       child: Stack(
//         children: [
//           // Lottie.asset(
//           //   "lib/image/Background_lottie_2.json",
//           //   width: MediaQuery.of(context).size.width,
//           //   height: MediaQuery.of(context).size.height,
//           //   fit: BoxFit.fill,
//           // ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   children: [
//                     CustomMorphisum(
//                       radius: 30,
//                       height: 160,
//                       width: MediaQuery.of(context).size.width,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Icon(
//                             Icons.person,
//                             size: 70,
//                             color: Theme.of(context).colorScheme.primary,
//                           ),
//                           Padding(
//                               padding: const EdgeInsets.all(8),
//                               child: _userDetail())
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     Container(
//                       height: 5,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(30),
//                         color: Theme.of(context).colorScheme.primary,
//                       ),
//                       width: MediaQuery.of(context).size.width * 0.8,
//                     ),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     CustomMorphisum(
//                       radius: 30,
//                       height: 60,
//                       width: MediaQuery.of(context).size.width,
//                       child: ListTile(
//                         contentPadding: const EdgeInsets.all(5),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         leading: Icon(
//                           Icons.person,
//                           size: 30,
//                           color: Theme.of(context).colorScheme.primary,
//                         ),
//                         title: Text(
//                           "Home",
//                           style: TextStyle(
//                               fontSize: 18,
//                               color: Theme.of(context).colorScheme.primary),
//                         ),
//                         onTap: () => Navigator.pop(context),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     CustomMorphisum(
//                       radius: 30,
//                       height: 60,
//                       width: MediaQuery.of(context).size.width,
//                       child: ListTile(
//                         contentPadding: const EdgeInsets.all(5),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         leading: Icon(
//                           Icons.person,
//                           size: 30,
//                           color: Theme.of(context).colorScheme.primary,
//                         ),
//                         title: Text(
//                           "Profile",
//                           style: TextStyle(
//                               fontSize: 18,
//                               color: Theme.of(context).colorScheme.primary),
//                         ),
//                         onTap: () => Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => const ProfileList())),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     CustomMorphisum(
//                       radius: 20,
//                       height: 60,
//                       width: MediaQuery.of(context).size.width,
//                       child: SwitchListTile(
//                         tileColor: Colors.transparent,
//                         value: themeState.getthemedata,
//                         contentPadding: const EdgeInsets.all(5),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         title: Text(
//                           "Theme",
//                           style: TextStyle(
//                               color: Theme.of(context).colorScheme.primary),
//                         ),
//                         secondary: Icon(
//                           themeState.getthemedata
//                               ? Icons.dark_mode_outlined
//                               : Icons.light_mode,
//                           color: Theme.of(context).colorScheme.primary,
//                         ),
//                         onChanged: (value) {
//                           themeState.themedata = value;
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 Center(
//                 child: Padding(
//                   padding: const EdgeInsets.all(8),
//                   child: SlideAction(
//                     borderRadius: 17,
//                     elevation: 0,
//                     innerColor: Theme.of(context).colorScheme.secondary,
//                     outerColor: Theme.of(context).colorScheme.tertiary,
//                     sliderButtonIcon: const Icon(Icons.logout),
//                     text: "Slide to Log-Out",
//                     textStyle: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w600,
//                         color: Theme.of(context).colorScheme.primary),
//                     onSubmit: () {
//                       _popup(context);
//                       return;
//                     },
//                   ),
//                 ),
//               ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
  
//  Future<AwesomeDialog> _popup(context) async {
//     return await AwesomeDialog(
//         dialogBackgroundColor: Theme.of(context).colorScheme.secondary,
//         context: context,
//         dialogType: DialogType.warning,
//         width: MediaQuery.of(context).size.width * 0.8,
//         buttonsBorderRadius: const BorderRadius.all(Radius.circular(30)),
//         dismissOnTouchOutside: true,
//         animType: AnimType.bottomSlide,
//         desc: "Log-Out\nCome back Soon!!!",
//         showCloseIcon: true,
//         btnOkOnPress: () {
//           FirebaseAuth.instance.signOut();
//         }).show();
//   }
// }
