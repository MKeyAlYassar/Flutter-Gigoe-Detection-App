import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class FetchDataResults extends StatefulWidget {
  const FetchDataResults({Key? key}) : super(key: key);
  @override
  State<FetchDataResults> createState() => _FetchDataResultsState();
}

class _FetchDataResultsState extends State<FetchDataResults> {
  Query dbRef = FirebaseDatabase.instance.ref().child('data');

  late DatabaseReference dbReff;

  @override
  void initState() {
    super.initState();

    dbRef = FirebaseDatabase.instance.ref().child('data');
  }

  Widget listItem({required Map results}) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.only(top: 5, bottom: 5),
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Container(
          height: 100,
          width: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Row(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  width: 50,
                  height: 50,
                  child: Image.asset('assets/icons/icon_profile.png'),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      results['nama'],
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.credit_card_rounded,
                          size: 20,
                          color: Color(0xff0E8388),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          results['nik'],
                          style: GoogleFonts.poppins(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_pin,
                          size: 20,
                          color: Color(0xff0E8388),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          results['alamat'],
                          style: GoogleFonts.poppins(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            title: Text(
              'Data Pasien',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      height: 230,
                      alignment: Alignment.centerLeft,
                      color: const Color.fromARGB(255, 255, 255, 255),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            results['nama'],
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            results['nik'],
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            results['alamat'],
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            results['email'],
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            results['gender'],
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            results['nomor'],
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            results['pekerjaan'],
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "Total Karies ${results['total_karies'] ?? '0'}",
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "Total Hilang ${results['total_hilang'] ?? '0'}",
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "Total Tambal ${results['total_tambal'] ?? '0'}",
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: double.infinity,
      child: FirebaseAnimatedList(
        query: FirebaseDatabase.instance.ref().child('data_pasien'),
        itemBuilder: (
          BuildContext context,
          DataSnapshot snapshot,
          Animation<double> animation,
          int index,
        ) {
          Map pasienMap = snapshot.value as Map;
          pasienMap['key'] = snapshot.key;
          return listItem(results: pasienMap);
        },
      ),
    );
  }
}
