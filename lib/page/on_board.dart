import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_verify_email/army_aircraft_icons.dart';
import 'package:firebase_auth_verify_email/page/home_page.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnBoardingScreen> {
  final controller = PageController();
  final scrollController = ScrollController();
  bool isLastPage = false;
  bool isFirstPage = true;
  bool isSecondPage = false;
  bool isThirdPage = false;

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).colorScheme;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // physics: NeverScrollableScrollPhysics()

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            titleSpacing: 10,
            backgroundColor: myTheme.inversePrimary,
            title: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    width: 50,
                    height: 50,
                    child: Image.asset('assets/images/insignia.png')),
                SizedBox(
                  width: 65,
                ),
                Text('Army Flight Hours'),
              ],
            ),
          ),
          resizeToAvoidBottomInset: true, // Set this to true
          body: SingleChildScrollView(
            controller: scrollController,
            child: Container(
              height: screenHeight * .95,
              padding: const EdgeInsets.only(bottom: 80),
              child: PageView(
                allowImplicitScrolling: true,
                physics: NeverScrollableScrollPhysics(),
                // Add this line
                controller: controller,
                onPageChanged: (index) {
                  setState(() {
                    isFirstPage = index == 0;
                    isSecondPage = index == 1;
                    isLastPage = index == 3;
                  });
                },
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('SELECT AIRFRAME', style: TextStyle(fontSize: 25)),
                      SizedBox(height: 20),
                      RadioExample(),
                      SizedBox(height: 20),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Container(
                        width: screenWidth * 0.85,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Select Rank'),
                            SizedBox(
                              height: 3,
                            ),
                            dropdownMenu(
                              listData: rank,
                              onSelectedValueChange: (value) {
                                selectedValues['rank'] = value;
                                selectedRank = selectedValues['rank'];
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text('Select Birth Month'),
                            SizedBox(
                              height: 3,
                            ),
                            dropdownMenu(
                              listData: months,
                              onSelectedValueChange: (value) {
                                selectedValues['month'] = value;
                                selectedMonth = selectedValues['month'];
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text('Select Flight Activity Level'),
                            SizedBox(
                              height: 3,
                            ),
                            dropdownMenu(
                              listData: fac,
                              onSelectedValueChange: (value) {
                                selectedValues['fac'] = value;
                                selectedFac = selectedValues['fac'];
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text('Select Readiness Level'),
                            SizedBox(
                              height: 3,
                            ),
                            dropdownMenu(
                              listData: rlLevel,
                              onSelectedValueChange: (value) {
                                selectedValues['rlLevel'] = value;
                                selectedRL = selectedValues['rlLevel'];
                              },
                            ),
                            SizedBox(height: 10),
                            Form(
                              key: _totalKey,
                              child: Column(
                                children: [
                                  userinputHours(
                                      label: 'Total Hours',
                                      controller: _totalHours),
                                  SizedBox(height: 20),
                                  userinputHours(
                                      label: 'Total NVD Hours',
                                      controller: _totalNVD),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                  Column(
                    children: [
                      Form(
                          key: _semiKey,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              userinputHours(
                                  label: 'Current Semi Annual hours',
                                  controller: _totalsemiHours),
                              userinputHours(
                                  label: 'Current Semi Annual Backseat hours',
                                  controller: _backSemi),
                              userinputHours(
                                  label: 'Current Semi Annual Frontseat hours',
                                  controller: _frontSemi),
                              userinputHours(
                                  label: 'Current Semi Annual NVS hours',
                                  controller: _nvsSemi),
                              userinputHours(
                                  label: 'Current Semi Annual NVG Hours',
                                  controller: _nvgSemi),
                              userinputHours(
                                  label: 'Current Semi Annual Unaided hours',
                                  controller: _nunaidedSemi),
                              userinputHours(
                                  label:
                                      'Current Semi Annual Hood/Weather hours',
                                  controller: _hwSemi),
                            ],
                          ))
                    ],
                  ),
                  Column(
                    children: [
                      Form(
                          key: _semisimKey,
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              userinputHours(
                                  label: 'Current Semi Annual Total SIM Hours',
                                  controller: _simtotalSemi),
                              userinputHours(
                                  label:
                                      'Current Semi Annual SIM Backset hours',
                                  controller: _bssimSemi),
                              userinputHours(
                                  label:
                                      'Current Semi Annual SIM Frontseat hours',
                                  controller: _fssimSemi),
                              userinputHours(
                                  label: 'Current Semi Annual G-COFT/E hours',
                                  controller: _gcoftSemi),
                            ],
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
          bottomSheet: isLastPage
              ? Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          child: const Text('Back',
                              style: TextStyle(fontSize: 18)),
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            controller.previousPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                            scrollController.jumpTo(0.0);
                          }),
                      TextButton(
                        child: const Text('Submit',
                            style: TextStyle(fontSize: 18)),
                        onPressed: () {
                          if (_semisimKey.currentState!.validate()) {
                            FocusManager.instance.primaryFocus?.unfocus();
                            initialOnboardData();
                            totalHours();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                )
              : isFirstPage
                  ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            child: const Text('Next',
                                style: TextStyle(fontSize: 18)),
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              scrollController.jumpTo(0.0);

                              if (selectedAirframe == null) {
                                final selectAirframe = SnackBar(
                                  duration: Duration(seconds: 2),
                                  content: Center(
                                    child: Container(
                                      height: 40,
                                      width: screenWidth * .5,
                                      padding: EdgeInsets.all(5),
                                      //screenWidth * .25,

                                      decoration: BoxDecoration(
                                          color: myTheme.errorContainer,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Center(
                                        child: Text('Select an Airframe',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ),
                                    ),
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(selectAirframe);
                              } else {
                                controller.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    )
                  : isSecondPage
                      ? Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          height: 80,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                child: const Text('Back',
                                    style: TextStyle(fontSize: 18)),
                                onPressed: () {
                                  scrollController.jumpTo(0.0);
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  controller.previousPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                  );
                                },
                              ),
                              TextButton(
                                child: const Text('Next',
                                    style: TextStyle(fontSize: 18)),
                                onPressed: () {
                                  scrollController.jumpTo(0.0);
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  if (_totalKey.currentState!.validate() &&
                                      selectedValues['rank'] != null &&
                                      selectedValues['month'] != null &&
                                      selectedValues['fac'] != null &&
                                      selectedValues['rlLevel'] != null) {
                                    controller.nextPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut,
                                    );
                                  } else if (selectedMonth == null ||
                                      selectedFac == null) {
                                    scrollController.jumpTo(0.0);
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    final selectAirframe = SnackBar(
                                      duration: Duration(seconds: 2),
                                      content: Center(
                                        child: Container(
                                          height: 40,
                                          width: screenWidth * .45,
                                          padding: EdgeInsets.all(5),
                                          //screenWidth * .25,

                                          decoration: BoxDecoration(
                                              color: myTheme.errorContainer,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15))),
                                          child: Center(
                                            child: Text(
                                                'Select a Rank, Birth Month, FAC and RL',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center),
                                          ),
                                        ),
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.transparent,
                                      elevation: 0,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(selectAirframe);
                                  }
                                },
                              ),
                            ],
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          height: 80,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                child: const Text('Back',
                                    style: TextStyle(fontSize: 18)),
                                onPressed: () {
                                  scrollController.jumpTo(0.0);
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  controller.previousPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                  );
                                },
                              ),
                              TextButton(
                                child: const Text('Next',
                                    style: TextStyle(fontSize: 18)),
                                onPressed: () {
                                  if (_semiKey.currentState!.validate()) {
                                    scrollController.jumpTo(0.0);
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    controller.nextPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut,
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        )),
    );
  }
}

enum SingingCharacter { Apache, Blackhawk, Chinook }

String? selectedAirframe;

class RadioExample extends StatefulWidget {
  @override
  _RadioExampleState createState() => _RadioExampleState();
}

class _RadioExampleState extends State<RadioExample> {
  SingingCharacter? _character = SingingCharacter.Apache;

  //String? selectedAirframe;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final myTheme = Theme.of(context).colorScheme;
    return Container(
      // width: screenWidth * 0.15,
      // height: screenHeight * 0.15,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            // width: screenWidth * 0.15,
            // height: screenHeight * 0.15,
            child: TextButton(
              onPressed: () {
                setState(() {
                  selectedAirframe = 'Apache';
                });
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 80, top: 30),
                    child: Icon(ArmyAircraft.apache,
                        color: selectedAirframe == 'Apache'
                            ? myTheme.error
                            : myTheme.primary,
                        size: 140.0),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return selectedAirframe == 'Blackhawk'
                        ? myTheme.error
                        : myTheme.primary;
                  } else {
                    return selectedAirframe == 'Blackhawk'
                        ? myTheme.error
                        : myTheme.primary;
                  }
                }),
              ),
            ),
          ),
          SizedBox(height: 0),
          Container(
            // width: 250,
            // height: 200,
            child: TextButton(
              onPressed: () {
                setState(() {
                  selectedAirframe = 'Blackhawk';
                });
              },
              child: Column(
                //  mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 50),
                    child: Icon(ArmyAircraft.blackhawk,
                        color: selectedAirframe == 'Blackhawk'
                            ? myTheme.error
                            : myTheme.primary,
                        size: 200),
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  //  Text('Blackhawk', style: TextStyle(fontSize: 20, color: selectedAirframe == 'Blackhawk' ? myTheme.error : myTheme.primary)),
                ],
              ),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return selectedAirframe == 'Blackhawk'
                        ? myTheme.error
                        : myTheme.primary;
                  } else {
                    return selectedAirframe == 'Blackhawk'
                        ? myTheme.error
                        : myTheme.primary;
                  }
                }),
              ),
            ),
          ),
          Container(
            // width: 250,
            // height: 200,
            child: TextButton(
              onPressed: () {
                setState(() {
                  selectedAirframe = 'Chinook';
                });
              },
              child: Column(
                //  mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 100, top: 20),
                    child: Icon(ArmyAircraft.chinook,
                        color: selectedAirframe == 'Chinook'
                            ? myTheme.error
                            : myTheme.primary,
                        size: 125),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //  Text('Chinook', style: TextStyle(fontSize: 20, color: selectedAirframe == 'Chinook' ? myTheme.error : myTheme.primary)),
                ],
              ),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return selectedAirframe == 'Chinook'
                        ? myTheme.error
                        : myTheme.primary;
                  } else {
                    return selectedAirframe == 'Chinook'
                        ? myTheme.error
                        : myTheme.primary;
                  }
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<String> months = [
  'JANUARY',
  'FEBRUARY',
  'MARCH',
  'APRIL',
  'MAY',
  'JUNE',
  'JULY',
  'AUGUST',
  'SEPTEMBER',
  'OCTOBER',
  'NOVEMBER',
  'DECEMBER'
];

List<String> fac = [
  'FAC 1',
  'FAC 2',
  'FAC 3',
];

List<String> rlLevel = [
  'RL 1',
  'RL 2',
  'RL 3',
];

List<String> rank = [
  'WO1',
  'CW2',
  'CW3',
  'CW4',
  'CW5',
  '2LT',
  '1LT',
  'CPT',
  'MAJ',
  'LTC',
  'COL',
  'CIVILIAN'
];
String? selectedRank;
String? selectedMonth;
String? selectedFac;
String? selectedRL;

Map<String, String> selectedValues = {};

class dropdownMenu extends StatefulWidget {
  final List<String> listData;
  final ValueChanged<String> onSelectedValueChange;

  const dropdownMenu({
    Key? key,
    required this.listData,
    required this.onSelectedValueChange,
  }) : super(key: key);

  @override
  State<dropdownMenu> createState() => _dropdownMenuState();
}

class _dropdownMenuState extends State<dropdownMenu> {
  String? selectedData;

  @override
  void initState() {
    super.initState();
    selectedData = widget.listData.first;
  }

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).colorScheme;
    double screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: screenWidth * 0.85,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(
                color: myTheme.primary,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: DropdownButton<String>(
              hint: Text('Choose a Value'),
              menuMaxHeight: 250,
              style: TextStyle(fontSize: 15),
              isExpanded: true,
              underline: Container(color: Colors.transparent),
              value: selectedData,
              onChanged: (String? value) {
                setState(() => selectedData = value!);
                widget.onSelectedValueChange(value!);
              },
              selectedItemBuilder: (BuildContext context) {
                return widget.listData.map<Widget>((String item) {
                  return Container(
                      alignment: Alignment.center,
                      // constraints: BoxConstraints(maxWidth: screenWidth * 0.5),
                      child: Text(
                        item,
                      ));
                }).toList();
              },
              items:
                  widget.listData.map<DropdownMenuItem<String>>((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

final _totalHours = TextEditingController();
final _totalNVD = TextEditingController();
final _totalsemiHours = TextEditingController();
final _backSemi = TextEditingController();
final _frontSemi = TextEditingController();
final _nvsSemi = TextEditingController();
final _nvgSemi = TextEditingController();
final _nunaidedSemi = TextEditingController();
final _hwSemi = TextEditingController();
final _simtotalSemi = TextEditingController();
final _bssimSemi = TextEditingController();
final _fssimSemi = TextEditingController();
final _gcoftSemi = TextEditingController();
final _totalKey = GlobalKey<FormState>();
final _semiKey = GlobalKey<FormState>();
final _semisimKey = GlobalKey<FormState>();

class userinputHours extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  //final FormFieldValidator<String> validator;

  userinputHours({
    required this.label,
    required this.controller,
    //required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).colorScheme;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(height: 3),
        Container(
          width: screenWidth * 0.85, // 80% of screen width
          // height: screenHeight * 0.05, // 10% of screen height
          // height: 60,
          child: TextFormField(
            textAlign: TextAlign.left,
            // style: TextStyle(fontSize: 22),
            decoration: InputDecoration(
              isDense: true,
              hintText: "0",
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 2.0),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: myTheme.primary),
                  borderRadius: BorderRadius.circular(5.0)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: myTheme.error),
                  borderRadius: BorderRadius.circular(5.0)),
            ),
            keyboardType: TextInputType.number,
            controller: controller,
            validator: (value) {
              double? parsedValue = double.tryParse(value!);
              if (parsedValue == null || parsedValue > 50000) {
                return 'Please enter a valid number';
              }
              return null;
            },
          ),
        ),
        SizedBox(height: 5),
      ],
    );
  }
}

Future initialOnboardData() async {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final uid = user?.uid;

  final onboardData = {
    "Airframe": selectedAirframe,
    "Birth Month": selectedMonth,
    "FAC Level": selectedFac,
  };

  await _usersCollection
      .doc(uid)
      .update(onboardData)
      .then((value) => print("Data Added"))
      .catchError((error) => print("Failed to add data: $error"));
}

Future totalHours() async {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final uid = user?.uid;

  final totalhnvd = {
    "Onboard Total Hours": int.parse(_totalHours.text),
    "Onboard Total NVD": int.parse(_totalHours.text),
    "Total Semi Annual Hours": int.parse(_totalsemiHours.text),
    "Total BS Semi Annual Hours": int.parse(_backSemi.text),
    "Total FS Semi Annual Hours": int.parse(_frontSemi.text),
    "Total NVS Semi Annual Hours": int.parse(_nvsSemi.text),
    "Total NVG Semi Annual Hours": int.parse(_nvgSemi.text),
    "Total Night Unaided Semi Annual Hours": int.parse(_nunaidedSemi.text),
    "Total H/W Semi Annual Hours": int.parse(_hwSemi.text),
    "Total SIM Semi Annual Hours": int.parse(_simtotalSemi.text),
    "Total SIM BS Semi Annual Hours": int.parse(_bssimSemi.text),
    "Total SIM FS Semi Annual Hours": int.parse(_fssimSemi.text),
    "Total GCOFT": int.parse(_gcoftSemi.text)
  };

  await _usersCollection
      .doc(uid)
      .collection('userdata')
      .doc('onboardhours')
      .set(totalhnvd)
      .then((value) => print("Data Added"))
      .catchError((error) => print("Failed to add data: $error"));
}
