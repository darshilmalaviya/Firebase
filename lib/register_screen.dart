import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flag/flag.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'otp_screen.dart';

class Register2 extends StatefulWidget {
  const Register2({Key? key}) : super(key: key);

  @override
  State<Register2> createState() => _Register2State();
}

class _Register2State extends State<Register2> {
  TextEditingController numberctnrl = TextEditingController();

  bool loading = false;

  FirebaseAuth auth = FirebaseAuth.instance;

  String countryCode = "91";
  String countryCodeIMage = "IN";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  top: 100,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Registration",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  top: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Enter your mobile number, we will send",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "you OTP to verify later",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                child: TextField(
                  controller: numberctnrl,
                  keyboardType: const TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    labelText: "Number Phone",
                    labelStyle:
                        const TextStyle(color: Colors.black, fontSize: 18),
                    prefix: SizedBox(
                      height: 20,
                      width: 75,
                      child: GestureDetector(
                        onTap: () {
                          showCountryPicker(
                            context: context,
                            showPhoneCode: true,
                            onSelect: (Country country) {
                              if (kDebugMode) {
                                print('Select country: ${country.phoneCode}');
                              }
                              countryCode = country.phoneCode;
                              countryCodeIMage = country.countryCode;
                              if (kDebugMode) {
                                print('Select country: $countryCodeIMage');
                              }
                              setState(() {});
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Flag.fromString(countryCodeIMage,
                                  height: 15, width: 30, fit: BoxFit.contain),
                              Text("+$countryCode"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              loading
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.only(left: 20, top: 50),
                      child: GestureDetector(
                        onTap: () async {
                          setState(() {
                            loading = true;
                          });
                          if (numberctnrl.text == '') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Number Can't Be Null"),
                              ),
                            );
                          } else {
                            await auth.verifyPhoneNumber(
                              phoneNumber: '+$countryCode ${numberctnrl.text}',
                              verificationCompleted: (phoneAuthCredential) {
                                setState(() {
                                  loading = false;
                                });
                                if (kDebugMode) {
                                  print('DONE');
                                }
                              },
                              verificationFailed: (error) {
                                setState(() {
                                  loading = false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("ERROR")));
                              },
                              codeSent: (verificationId, forceResendingToken) {
                                setState(() {
                                  loading = false;
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Otpscreen(
                                        number:
                                            '+$countryCode ${numberctnrl.text}',
                                        code: countryCode,
                                        verficationId: verificationId,
                                        forcetoken: forceResendingToken,
                                      ),
                                    ));
                              },
                              codeAutoRetrievalTimeout: (verificationId) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("REQUEST TIME OUT")));
                              },
                            );
                          }
                        },
                        child: Container(
                          height: 70,
                          width: 350,
                          decoration: BoxDecoration(
                            // ignore: use_full_hex_values_for_flutter_colors
                            color: const Color(0xffffb847c),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                              child: Text(
                            "SEND VIA SMS",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          )),
                        ),
                      ),
                    ),
              const Padding(
                padding: EdgeInsets.only(top: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "By creating and/or using an account, you",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "agree to our",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    " Terms & Conditions",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color(0xffFF928E),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
