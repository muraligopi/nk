import 'package:Nkipay/pages/homepage.dart';
import 'package:Nkipay/responsive.dart';
import 'package:Nkipay/utils/constants.dart';
import 'package:Nkipay/utils/showSnackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final current_user = FirebaseAuth.instance.currentUser!;
//getting transactions history of current user from FS and display as list...

// class currentUserPayment extends StatefulWidget {
//   const currentUserPayment({Key? key}) : super(key: key);

//   @override
//   State<currentUserPayment> createState() => _currentUserPaymentState();
// }

// class _currentUserPaymentState extends State<currentUserPayment> {
//   @override
//   final ref = FirebaseFirestore.instance
//       .collection('Transaction_Histroy')
//       .where('email id', isEqualTo: user.email!);

//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder(
//         stream: ref.snapshots(),
//         builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.hasError) {
//             return Text('something gone wrong');
//           } else if (snapshot.hasData) {
//             return ListView.builder(
//               itemCount: snapshot.data!.docs.length,
//               itemBuilder: (context, index) {
//                 var doc = snapshot.data!.docs[index].data();
//                 return ListTile(
//                   title: Text(
//                     doc!['user email'],
//                     style: TextStyle(color: Colors.purple),
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }

//1st copy

class currentUserPayment extends StatefulWidget {
  const currentUserPayment({Key? key}) : super(key: key);

  @override
  State<currentUserPayment> createState() => _currentUserPaymentState();
}

class _currentUserPaymentState extends State<currentUserPayment> {
  final role = TextEditingController();
  // final auth = FirebaseAuth.instance;

  void dispose() {
    super.dispose();
    role.dispose();
  }

  String dropdownvalue = 'success';

  // List of items in our dropdown menu
  var items = ['success', 'Pending', 'failed'];

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<List<UserModel>>(
            stream: helper.read(),
            builder: (context, snapshot) {
              // if (snapshot.connectionState == ConnectionState.waiting) {
              //   return const Center(
              //     child: CircularProgressIndicator(),
              //   );
              //}

              if (snapshot.hasError) {
                return const Text('something gone wrong');
              } else if (snapshot.hasData) {
                final userdata = snapshot.data;

                //       builder:
                // (BuildContext context, BoxConstraints viewportConstraints);
                return Container(
                  child: ListView.builder(
                      itemCount: userdata!.length,
                      itemBuilder: (context, index) {
                        final signleuser = userdata[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                              leading: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 7, 0, 2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${signleuser.amount}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  )),
                              title: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        "paid by: "
                                        "${signleuser.user_email}",
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        'Tansaction Id: '
                                        "${signleuser.uid}",
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        'customer phone number: '
                                        "${signleuser.phonenumber}",
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        'Paid number: '
                                        "${signleuser.phonenumber}",
                                      ),
                                    )
                                  ]),
                              // title: Container(child: Center(
                              //   child: Column(children: <Widget>[
                              //     child: Text(
                              //       "${signleuser.user_email}",

                              //     ),
                              //     child: Text(
                              //       "${signleuser.uid}",

                              //     ),
                              //   ],)

                              // ),),
                              //title: Text("${signleuser.user_email}"),
                              // subtitle: Text('customer phone number: ' +
                              //     "${signleuser.phonenumber}"),
                              trailing: IconButton(
                                icon: Icon(Icons.edit_note),
                                color: Colors.pinkAccent,
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => Dialog(
                                            child: Container(
                                              color: kPrimaryColor,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: ListView(
                                                  shrinkWrap: true,
                                                  children: <Widget>[
                                                    DropdownButton(
                                                      value: dropdownvalue,
                                                      icon: const Icon(Icons
                                                          .keyboard_arrow_down),
                                                      items: items
                                                          .map((String items) {
                                                        return DropdownMenuItem(
                                                          value: items,
                                                          child: Text(items),
                                                        );
                                                      }).toList(),
                                                      onChanged:
                                                          (String? newValue) {
                                                        setState(() {
                                                          dropdownvalue =
                                                              newValue!;
                                                        });
                                                      },
                                                    ),
                                                    const SizedBox(
                                                        height:
                                                            defaultPadding / 2),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        // helper.update(UserModel( phonenumber: dropdownvalue.toString(), ));
                                                      },
                                                      child: Text("report"
                                                          .toUpperCase()),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ));
                                },
                              )),
                        );
                      }),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      );
}

//geeting data from fs for updateing purpose

class helper {
  static Stream<List<UserModel>> read() {
    final user_transaction_collection = FirebaseFirestore.instance
        .collection('Transaction_Histroy')
        .where('user_email', isEqualTo: user.email!)
        .orderBy('pay_at', descending: true);
    return user_transaction_collection.snapshots().map((QuerySnapshot) =>
        QuerySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }

  static Future update(UserModel userModel) async {
    final user_transaction_sollection =
        FirebaseFirestore.instance.collection('Transaction_Histroy');
    final docref = user_transaction_sollection.doc(userModel.uid);

    final update_Trans = UserModel(
      user_email: userModel.user_email,
      phonenumber: userModel.phonenumber,
      amount: userModel.amount,
      uid: userModel.uid,
    ).toJson();

    try {
      await docref.update(update_Trans);
    } catch (e) {
      print('error check $e');
    }
  }
}

//user model
class UserModel {
  final String uid;
  final String phonenumber;
  final String amount;
  final String user_email;

  UserModel({
    required this.user_email,
    required this.phonenumber,
    required this.amount,
    required this.uid,
  });

  Map<String, dynamic> toJson() => {
        'user_email': user_email,
        'phone_number': phonenumber,
        'amount': amount,
        'uid': uid,
      };

  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
      user_email: snapshot['user_email'],
      phonenumber: snapshot['phone_number'],
      amount: snapshot['amount'].toString(),
      uid: snapshot['uid'].toString(),
    );
  }
  // UserModel(
  //   user_email: json['user email'],
  //   phonenumber: json['phone_number'],
  //   amount: json['amount']
  //   //date: json['date of paid'] as Timestamp.toDate(),
  //   );

}

// ....................................
// child: Column(children: const [
//             SizedBox(
//               height: 20,
//             ),
//              TextField(
//               decoration: InputDecoration(
//                 labelText: 'search', suffixIcon: Icon(Icons.search)
//               ),
//             ),
//             SizedBox(height: 20,),
//             Expanded()
//           ],);

//getting transactions history of current user from FS and display as list...
// class currentUserPayment extends StatefulWidget {
//   const currentUserPayment({Key? key}) : super(key: key);

//   @override
//   State<currentUserPayment> createState() => _currentUserPaymentState();
// }

// Stream<List<User>> ListData() => FirebaseFirestore.instance
//     .collection('Transaction_Histroy')
//     .where('user_email', isEqualTo: user.email!)
//     .snapshots()
//     .map((snapshot) =>
//         snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());

// class _currentUserPaymentState extends State<currentUserPayment> {
//   @override
//   Widget build(BuildContext context) => Scaffold(
//         body: StreamBuilder<List<User>>(
//           stream: ListData(),
//           builder: (context, snapshot) {
//             if (snapshot.hasError) {
//               return Text('something went wrong');
//             } else if (snapshot.hasData) {
//               final user_payments = snapshot.data;
//               MainAxisAlignment.center;
//               BorderRadius.all(Radius.circular(20));
//               return ListView(
//                 children: user_payments!.map(builduser_payments).toList(),
//               );
//             } else {
//               return Center(child: CircularProgressIndicator());
//             }
//           },
//         ),
//       );
// }

// Widget builduser_payments(User user_payments) => ListTile(
//       leading: CircleAvatar(child: Text('${user_payments.amount}')),
//       title: Text(user_payments.user_email),
//       subtitle: Text(user_payments.phonenumber),
//     );

// class User {
//   final String phonenumber;
//   final String amount;
//   final String user_email;

//   User({
//     required this.user_email,
//     required this.phonenumber,
//     required this.amount,
//     // required this.paid_data_time
//   });

//   Map<String, dynamic> toJson() =>
//       {'user_email': user_email, 'phone_number': phonenumber, 'amount': amount};

//   static User fromJson(Map<String, dynamic> json) => User(
//       user_email: json['user_email'],
//       phonenumber: json['phone_number'],
//       amount: json['amount'].toString()
//       // date: json['date of paid'] as Timestamp.toDate(),
//       );
// }
