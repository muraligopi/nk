import 'package:Nkipay/pages/homepage.dart';
import 'package:Nkipay/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//getting current user details from fs..
class current_user_details extends StatefulWidget {
  const current_user_details({Key? key}) : super(key: key);

  @override
  State<current_user_details> createState() => _current_user_detailsState();
}

double cur_bal = 0;
String role = '';

class _current_user_detailsState extends State<current_user_details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where('email id', isEqualTo: user.email!)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Text('something went wrong');
              }
              return ListView(
                  children: snapshot.data!.docs.map((document) {
                cur_bal = document['current_Balance'];
                role = document['role'];
                print(cur_bal.runtimeType);
                return Column(
                  children: [
                    Center(
                      child: Container(
                        //color: kPrimaryColor,
                        width: MediaQuery.of(context).size.width / 2,
                        //height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            gradient: const LinearGradient(colors: [
                              kPrimaryColor,
                              kPrimaryColor
                              //Colors.white
                            ])),
                        child: Padding(
                          padding: const EdgeInsets.all(defaultPadding),
                          child: Column(
                            children: [
                              Text(
                                "Username : " + document['username'],
                                style: GoogleFonts.josefinSans(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 247, 243, 243),
                                  // height: 1.3,
                                  fontSize: 16.0,
                                ),
                              ),
                              Text(
                                "Current Balance : " +
                                    document['current_Balance'].toString(),
                                style: GoogleFonts.josefinSans(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 248, 246, 246),
                                  height: 1.3,
                                  fontSize: 16.0,
                                ),
                              ),
                              Text(
                                "Email: " + document['email id'],
                                style: GoogleFonts.josefinSans(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 244, 243, 243),
                                  height: 1.3,
                                  fontSize: 16.0,
                                ),
                              ),
                              Text(
                                "Role : " + document['role'].toString(),
                                style: GoogleFonts.josefinSans(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 249, 248, 248),
                                  height: 1.3,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      tooltip: "Add money",
                      icon: const Icon(
                        Icons.add,
                        color: kPrimaryColor,
                      ),
                      onPressed: () {},
                    ),
                    Container(
                      child: const Text(
                        'Add money',
                        style: TextStyle(color: Color.fromARGB(255, 16, 0, 0)),
                      ),
                    ),
                  ],
                );
              }).toList());
            }),
      ),
    );
  }
}
