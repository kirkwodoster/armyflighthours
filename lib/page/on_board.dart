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
    print(selectedMonth);
    print(selectedAirframe);
    print(selectedRL);
    print(selectedFac);
    print(selectedRank);

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
                // allowImplicitScrolling: true,
                // physics: NeverScrollableScrollPhysics(),
                physics: BouncingScrollPhysics(),
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
                      Container(
                        width: screenWidth * 0.85,
                        // height: screenHeight * 0.95,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Text('User Info'),
                            DropdownMenuExample(
                                onSelectedValueChange: (label) =>
                                    setState(() => selectedRank = rank.text),
                                controllerType: rank,
                                hintText: 'Rank',
                                boxlabel: 'Rank',
                                labels: [
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
                                  'CIVILIAN',
                                ]),
                            DropdownMenuExample(
                              onSelectedValueChange: (label) => setState(
                                  () => selectedMonth = birthDate.text),
                              controllerType: birthDate,
                              hintText: 'Birth Month',
                              boxlabel: 'Birth Month',
                              labels: [
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
                              ],
                            ),
                            DropdownMenuExample(
                              onSelectedValueChange: (label) =>
                                  setState(() => selectedType = type.text),
                              controllerType: type,
                              boxlabel: 'PC or PI',
                              hintText: 'Type',
                              labels: ['PC', 'PI'],
                            ),
                            Visibility(
                              visible: type.text ==
                                  "PC", // Use 'change' for visibility check
                              child: DropdownMenuExample(
                                onSelectedValueChange: (label) => setState(
                                    () => selectedpcTrack = tracks.text),
                                boxlabel: 'PC Track',
                                controllerType: tracks,
                                hintText: 'Type',
                                labels: [
                                  'Untracked',
                                  'IP',
                                  'SP',
                                  'MTP',
                                  'AMSO',
                                  'Safety'
                                ],
                              ),
                            ),
                            Visibility(
                              visible: type.text ==
                                  "PI", // Use 'change' for visibility check
                              child: DropdownMenuExample(
                                onSelectedValueChange: (label) =>
                                    setState(() => selectedRL = rlLevel.text),
                                controllerType: rlLevel,
                                hintText: 'Readiness Level',
                                boxlabel: 'RL Level',
                                labels: [
                                  'RL 1 ',
                                  'RL 2',
                                  'RL 3',
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 100),
                      Form(
                        key: _totalKey,
                        child: Column(
                          children: [
                            userinputHours(
                                label: 'Total Hours', controller: _totalHours),
                            SizedBox(height: 20),
                            // userinputHours(
                            //     label: 'Total NVD Hours',
                            //     controller: _totalNVD),
                            // Padding(
                            //   padding: EdgeInsets.only(
                            //       bottom:
                            //           MediaQuery.of(context).viewInsets.bottom),
                            // )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(height: 20),
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

                                  if (selectedRank != null &&
                                      selectedMonth != null &&
                                      selectedType == 'PI' &&
                                      selectedRL != null) {
                                    print('First if');

                                    controller.nextPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut,
                                    );
                                  } else if (selectedRank != null &&
                                      selectedMonth != null &&
                                      selectedType == 'PC' &&
                                      selectedpcTrack != null) {
                                    print('Second if');
                                    controller.nextPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut,
                                    );
                                  } else if (_totalKey.currentState!
                                      .validate()) {
                                    controller.nextPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut,
                                    );
                                  } else {
                                    print('Else');
                                    print('Selected Rank: $selectedRank');
                                    print('Selected Month: $selectedMonth');
                                    print('Selected Type: $selectedType');
                                    print('Selected RL: $selectedRL');
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
                                                'Select a Rank, Birth Month, and/or PC/PI',
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

// List<String> months = [
//   'JANUARY',
//   'FEBRUARY',
//   'MARCH',
//   'APRIL',
//   'MAY',
//   'JUNE',
//   'JULY',
//   'AUGUST',
//   'SEPTEMBER',
//   'OCTOBER',
//   'NOVEMBER',
//   'DECEMBER'
// ];
//
// List<String> rlLevel = [
//   'RL 1',
//   'RL 2',
//   'RL 3',
// ];
//
// List<String> rank = [
//   'WO1',
//   'CW2',
//   'CW3',
//   'CW4',
//   'CW5',
//   '2LT',
//   '1LT',
//   'CPT',
//   'MAJ',
//   'LTC',
//   'COL',
//   'CIVILIAN'
// ];
//
// List<String> fac = [
//   'FAC 1 ',
//   'FAC 2',
//   'FAC 3',
// ];
//
// // List<String> type = ['PI', 'PC'];
//
// List<String> pcTrack = ['Untracked', 'IP', 'SP', 'MTP', 'AMSO', 'Safety'];

// String? selectedRank = "WO1";
// String? selectedMonth = "JANUARY";
// String? selectedFac = "FAC 1";
// String? selectedRL = " RL 1";
// String? selectedType = 'PC';
// String? selectedpcTrack = 'Untracked';

String? selectedRank;
String? selectedMonth;
String? selectedFac;
String? selectedRL;
String? selectedType;
String? selectedpcTrack;

// Map<String, String> selectedValues = {};

class dropdownMenu extends StatefulWidget {
  final List<String> listData;
  final ValueChanged<String> onSelectedValueChange;
  final String hintText;
  final String title;

  const dropdownMenu({
    Key? key,
    required this.listData,
    required this.onSelectedValueChange,
    required this.hintText,
    required this.title,
  }) : super(key: key);

  @override
  State<dropdownMenu> createState() => _dropdownMenuState();
}

class _dropdownMenuState extends State<dropdownMenu> {
  String? selectedData;

  @override
  void initState() {
    super.initState();
    // selectedData = widget.listData.first;
  }

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).colorScheme;
    double screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Container(alignment: Alignment.centerLeft, child: Text(widget.title)),
          SizedBox(
            height: 3,
          ),
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
              hint: Container(
                  alignment: Alignment.center, child: Text(widget.hintText)),
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
          SizedBox(
            height: 10,
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

final _userinputHoursKey = GlobalKey();

FocusNode fieldOne = FocusNode();

class userinputHours extends StatefulWidget {
  final String label;
  final TextEditingController controller;

  //final FormFieldValidator<String> validator;

  userinputHours({
    required this.label,
    required this.controller,
    //required this.validator,
  });

  @override
  State<userinputHours> createState() => _userinputHoursState();
}

class _userinputHoursState extends State<userinputHours> {
  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).colorScheme;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label),
        SizedBox(height: 3),
        Container(
          width: screenWidth * 0.85, // 80% of screen width
          // height: screenHeight * 0.1, // 10% of screen height
          // height: 60,
          child: TextFormField(
            textAlign: TextAlign.left,
            focusNode: myFocusNode,
            // focusNode: fieldOne,
            // style: TextStyle(fontSize: 22),
            decoration: InputDecoration(
              isDense: true,
              hintText: "0",
              // contentPadding: EdgeInsets.all(10),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 5.0),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: myTheme.primary, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: myTheme.error),
                  borderRadius: BorderRadius.circular(10.0)),
            ),
            onTap: () {
              Scrollable.ensureVisible(
                _userinputHoursKey.currentContext!,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            keyboardType: TextInputType.number,
            controller: widget.controller,
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
      .collection('userdata')
      .doc('userinfo')
      .set(onboardData, SetOptions(merge: true))
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
      .set(totalhnvd, SetOptions(merge: true))
      .then((value) => print("Data Added"))
      .catchError((error) => print("Failed to add data: $error"));
}

// class dropdown extends StatefulWidget {
//   final List<String> listData;
//   final ValueChanged<String> onSelectedValueChange;
//   final String hintText;
//   final String title;
//
//   const dropdownButton({
//     Key? key,
//     required this.listData,
//     required this.onSelectedValueChange,
//     required this.hintText,
//     required this.title,
//   }) : super(key: key);
//
//   @override
//   State<dropdownButton> createState() => _dropdownButtonState();
// }
//
// class _dropdownButtonState extends State<dropdownButton> {
//   String? selectedData;
//
//   @override
//   void initState() {
//     super.initState();
//     // selectedData = widget.listData.first;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final myTheme = Theme.of(context).colorScheme;
//     double screenWidth = MediaQuery.of(context).size.width;
//
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           SizedBox(
//             height: 10,
//           ),
//           Container(alignment: Alignment.centerLeft, child: Text(widget.title)),
//           SizedBox(
//             height: 3,
//           ),
//           Container(
//             width: screenWidth * 0.85,
//             height: 40,
//             decoration: BoxDecoration(
//               border: Border.all(
//                 color: myTheme.primary,
//               ),
//               borderRadius: BorderRadius.circular(5.0),
//             ),
//             child: DropdownMenu<String>(
//               hintText: widget.hintText,
//               menuHeight: 250,
//               textStyle: TextStyle(fontSize: 15),
//               // isExpanded: true,
//               // underline: Container(color: Colors.transparent),
//               // value: selectedData,
//               onSelected: (String? value) {
//                 setState(() => selectedData = value!);
//                 widget.onSelectedValueChange(value!);
//               },
//
//               dropdownMenuEntries:
//                   widget.listData.map<DropdownMenuEntry<String>>((String item) {
//                 return DropdownMenuEntry<String>(
//                   value: item,
//                   label: '',
//                 );
//               }).toList(),
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//

// DropdownMenuEntry labels and values for the first dropdown menu.
// enum Track {
//   first('PC', 1),
//   second('PI', 2);
//
//   const Track(this.label, this.number);
//   final String label;
//   final int number;
// }

// class dropdownButton extends StatefulWidget {
//   final List<String> listData;
//   const dropdownButton({
//     Key? key,
//     required this.listData,
//   }) : super(key: key);
//
//   @override
//   State<dropdownButton> createState() => _dropdownButtonState();
// }
//
// class _dropdownButtonState extends State<dropdownButton> {
//   final TextEditingController colorController = TextEditingController();
//   final TextEditingController iconController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     final myTheme = Theme.of(context).colorScheme;
//     double screenWidth = MediaQuery.of(context).size.width;
//     return Column(
//       children: <Widget>[
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 20),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               DropdownMenu<listData>(
//                 // initialSelection: Track.blue,
//                 controller: colorController,
//                 width: screenWidth * 0.75,
//                 enableSearch: false,
//                 enableFilter: false,
//
//                 // requestFocusOnTap is enabled/disabled by platforms when it is null.
//                 // On mobile platforms, this is false by default. Setting this to true will
//                 // trigger focus request on the text field and virtual keyboard will appear
//                 // afterward. On desktop platforms however, this defaults to true.
//                 requestFocusOnTap: true,
//                 inputDecorationTheme: InputDecorationTheme(
//                     enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                   borderSide: BorderSide(
//                       color: myTheme.primary,
//                       width: 2), // Change the color and width here
//                 )),
//                 label: const Text(
//                   'Select Track',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 onSelected: (enumList? color) {
//                   setState(() {
//                     selectedColor = color;
//                   });
//                 },
//                 dropdownMenuEntries: enumList.values
//                     .map<DropdownMenuEntry<enumList>>((enumList color) {
//                   return DropdownMenuEntry<enumList>(
//                     value: color,
//                     label: color.label,
//                     enabled: color.label != 'Grey',
//                     style: MenuItemButton.styleFrom(
//                         // foregroundColor: myTheme.primary,
//                         // backgroundColor: myTheme.primary,
//                         ),
//                   );
//                 }).toList(),
//               ),
//               const SizedBox(width: 24),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// enum Track {
//   blue('PC', 1),
//   pink('PI', 2);
//
//   const Track(this.label, this.number);
//   final String label;
//   final int number;
// }
//
// class CustomDropdown<T> extends StatefulWidget {
//   final String label;
//   final T? initialValue;
//   final List<T> items;
//   final Function(T) onSelected;
//   final double width;
//   final bool enableSearch;
//   final bool enableFilter;
//
//   const CustomDropdown({
//     required this.label,
//     this.initialValue,
//     required this.items,
//     required this.onSelected,
//     this.width = double.infinity,
//     this.enableSearch = false,
//     this.enableFilter = false,
//   });
//
//   @override
//   State<CustomDropdown<T>> createState() => _CustomDropdownState<T>();
// }
//
// class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
//   T? _selectedValue;
//
//   @override
//   void initState() {
//     super.initState();
//     _selectedValue = widget.initialValue;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
//     final myTheme = Theme.of(context).colorScheme;
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 20),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               DropdownMenu<T>(
//                 width: 200,
//                 enableSearch: widget.enableSearch,
//                 enableFilter: widget.enableFilter,
//                 requestFocusOnTap: true,
//                 inputDecorationTheme: InputDecorationTheme(
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                     borderSide: BorderSide(
//                       color: myTheme.primary,
//                       width: 2,
//                     ),
//                   ),
//                 ),
//                 label: Text(widget.label,
//                     style: TextStyle(color: myTheme.primary)),
//                 onSelected: (T? value) => setState(() {
//                   _selectedValue = value;
//                   widget.onSelected(value!);
//                 }),
//                 dropdownMenuEntries: widget.items.map((T value) {
//                   // Cast to access label property
//                   return DropdownMenuEntry<T>(
//                     value: value,
//                     label: value.toString(),
//                     // Adjust display based on enum type
//                   );
//                 }).toList(),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

String? change = '';

final TextEditingController rank = TextEditingController();
final TextEditingController birthDate = TextEditingController();
final TextEditingController rlLevel = TextEditingController();
final TextEditingController type = TextEditingController();
final TextEditingController tracks = TextEditingController();
final TextEditingController fac = TextEditingController();

class DropdownMenuExample extends StatefulWidget {
  final List<String> labels;
  final String? hintText;
  final dynamic controllerType;
  final Function(String)? onSelectedValueChange;
  final String boxlabel;

  // final ValueChanged<String?> subject;

  // final List<int> values;

  const DropdownMenuExample({
    super.key,
    required this.labels,
    required this.hintText,
    required this.controllerType,
    this.onSelectedValueChange,
    required this.boxlabel,
    // required this.subject,
  });

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  String? _selectedLabel;

  @override
  void initState() {
    super.initState();
    // Initialize _selectedLabel with the first item in the list if desired:
    _selectedLabel = widget.labels.first;
  }

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).colorScheme;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      // width: screenWidth * .8,
      // height: 150,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DropdownMenu<String>(
                  width: screenWidth * .85,
                  hintText: widget.hintText,
                  menuHeight: 300,
                  label: Text(widget.boxlabel),
                  // initialSelection: 0,
                  controller: widget.controllerType,
                  requestFocusOnTap: false,
                  inputDecorationTheme: InputDecorationTheme(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 10.0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: myTheme.primary,
                        width: 2,
                      ),
                    ),
                  ),
                  // label: const Text(widget.hintText),
                  onSelected: (String? label) {
                    setState(() {
                      _selectedLabel = label;
                      widget.onSelectedValueChange!(label!);

                      // Perform actions based on the selected label here, e.g.,
                      // update other UI elements or perform computations:
                      // print('Selected label: $_selectedLabel');
                      // ...
                    });
                  },
                  dropdownMenuEntries: widget.labels
                      .asMap()
                      .entries
                      .map(
                        (entry) => DropdownMenuEntry<String>(
                            value: entry.value.toString(),
                            label: entry.value.toString()),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
          // SizedBox(
          //   height: 5,
          // )
        ],
      ),
    );
  }
}
