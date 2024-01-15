
import 'package:firebase_auth_verify_email/army_aircraft_icons.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';



// import 'package:flutter/services.dart';


class OnBoardingScreen extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnBoardingScreen> {
  final controller = PageController();
  bool isLastPage = false;
  bool isFirstPage = true;
  

  @override
  void dispose() {
    controller.dispose();

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
        resizeToAvoidBottomInset: true, // Set this to true
        body: SingleChildScrollView(
        child: Container(
          height: screenHeight*.95,
        padding: const EdgeInsets.only(bottom: 80),
          child: PageView(
            allowImplicitScrolling: true,
            physics: NeverScrollableScrollPhysics(), // Add this line
            controller: controller,
            onPageChanged: (index) {
            setState(() {
            isLastPage = index == 2;
            isFirstPage = index == 0;
            });
            },
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('SELECT AIRFRAME', style:TextStyle(fontSize: 25)),
                  SizedBox(height: 20),
                  RadioExample(),
                  SizedBox(height: 20),

                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text('Input Total Hours and NVS'),
                  // SizedBox(height: 20),
                  // totalhoursInput(),
                 SizedBox(height: 10),
                 Form(
                  key: _totalKey,
                   child: Column(
                     children: [
                       userinputHours(
                        label: 'Total Hours',
                        controller: _totalHours),
                      userinputHours(
                        label: 'Total NVD Hours',
                        controller: _totalNVD),
                     ],
                   ),
                 ),
                  SizedBox(height: 20),
                  Container(
                      width: screenWidth * 0.85,
                      child: Text('Select Month of Birth',  textAlign: TextAlign.left)),
                  SizedBox(height: 20),
                  MonthButton(),
                  SizedBox(height: 20),
                  Container(
                      width: screenWidth * 0.85,
                      child: Text('Select FAC Level',  textAlign: TextAlign.left)),
                  SizedBox(height: 20),
                  facAviator(),
                  SizedBox(height: 20),
                ],

              ),
              // Stack(alignment: Alignment.center, children: [DateInput()])
              Column(
                children: [


               Form(key: _semiKey,
                child: Column(children: [
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
                  label: 'Current Semi Annual Hood/Weather hours',
                  controller: _hwSemi),
                   userinputHours(
                  label: 'Current Semi Annual Total SIM Hours',
                  controller: _simtotalSemi),
                  userinputHours(
                  label: 'Current Semi Annual SIM Backset hours',
                  controller: _bssimSemi),
                  userinputHours(
                  label: 'Current Semi Annual SIM Frontseat hours',
                  controller: _fssimSemi),
                  userinputHours(
                  label: 'Current Semi Annual G-COFT/E hours',
                  controller: _fssimSemi),


             ],))

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
                      child: const Text('Back'),
                      onPressed: () => controller.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,

                      ),

                    ),
                    TextButton(
                      child: const Text('Submit'),
                      onPressed: () {
                        initialOnboardData();
                      },

                      // async {
                      //   await _usersCollection.doc(uid).update(onboardData).then((value) => print("Data Added"))
                      //       .catchError((error) => print("Failed to add data: $error"));
                      // },
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
                          child: const Text('Next'),
                          onPressed: () {
                          if (selectedAirframe == null) {

                            final selectAirframe = SnackBar(
                              content: Center(
                                child: Container(
                                  height: 40,
                                  width: screenWidth*.5,
                                  padding: EdgeInsets.all(5
                                  ),//screenWidth * .25,

                                  decoration: BoxDecoration(

                                       color: myTheme.errorContainer,
                                       borderRadius: BorderRadius.all(Radius.circular(20))

                                      ),
                                  child: Center(child: Text('Select an Airframe', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold,)),

                                  ),
                                ),
                              ),

                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              elevation: 0,



                            );
                            ScaffoldMessenger.of(context).showSnackBar(selectAirframe);

                          }else{
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
                : Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          child: const Text('Back'),
                          onPressed: () => controller.previousPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          ),
                        ),
                        TextButton(
                        child: const Text('Next'),
                        onPressed: () {
                          if (_totalKey.currentState!.validate() && selectedMonth != null && selectedFac != null) {
                            controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );

                          }else if(selectedMonth == null || selectedFac == null){
                            final selectAirframe = SnackBar(
                              content: Center(
                                child: Container(
                                  height: 40,
                                  width: screenWidth*.45,
                                  padding: EdgeInsets.all(5
                                  ),//screenWidth * .25,

                                  decoration: BoxDecoration(

                                       color: myTheme.errorContainer,
                                       borderRadius: BorderRadius.all(Radius.circular(20))

                                      ),
                                  child: Center(child: Text('Select a Birth Month and FAC Level', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold,)),

                                  ),
                                ),
                              ),

                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              elevation: 0,



                            );
                            ScaffoldMessenger.of(context).showSnackBar(selectAirframe);


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
               child: Icon(ArmyAircraft.apache, color: selectedAirframe == 'Apache' ? myTheme.error : myTheme.primary, size: 140.0),
           ),
           SizedBox(height: 10,),
       ],
   ),
   style: ButtonStyle(
       
       foregroundColor: MaterialStateProperty.resolveWith(
           (Set<MaterialState> states) {
               if (states.contains(MaterialState.pressed)) {
                  return selectedAirframe == 'Blackhawk' ? myTheme.error : myTheme.primary;
               } else {
                  return selectedAirframe == 'Blackhawk' ? myTheme.error : myTheme.primary;
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
       child: Icon(ArmyAircraft.blackhawk, color: selectedAirframe == 'Blackhawk' ? myTheme.error : myTheme.primary, size: 200  ),
     ),
     SizedBox(height: 0,),
    //  Text('Blackhawk', style: TextStyle(fontSize: 20, color: selectedAirframe == 'Blackhawk' ? myTheme.error : myTheme.primary)),
     ],
     ),
     style: ButtonStyle(
    
     foregroundColor: MaterialStateProperty.resolveWith(
     (Set<MaterialState> states) {
     if (states.contains(MaterialState.pressed)) {
       return selectedAirframe == 'Blackhawk' ? myTheme.error : myTheme.primary;
     } else {
       return selectedAirframe == 'Blackhawk' ? myTheme.error : myTheme.primary;
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
     selectedAirframe = 'Chinook';
     });
     },
     
     child: Column(
    //  mainAxisSize: MainAxisSize.min,
     children: [
     Padding(
       padding: const EdgeInsets.only(right: 100, top: 20),
       child: Icon(ArmyAircraft.chinook, color: selectedAirframe == 'Chinook' ? myTheme.error : myTheme.primary, size: 125),
     ),SizedBox(height: 10,),
    //  Text('Chinook', style: TextStyle(fontSize: 20, color: selectedAirframe == 'Chinook' ? myTheme.error : myTheme.primary)),
     ],
     ),
     style: ButtonStyle(
    
     foregroundColor: MaterialStateProperty.resolveWith(
     (Set<MaterialState> states) {
     if (states.contains(MaterialState.pressed)) {
       return selectedAirframe == 'Chinook' ? myTheme.error : myTheme.primary;
     } else {
       return selectedAirframe == 'Chinook' ? myTheme.error : myTheme.primary;
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






String? selectedMonth;
// int? selectedMontint;
class MonthButton extends StatefulWidget {
  const MonthButton({Key? key}) : super(key: key);

  @override
  _MonthButtonState createState() => _MonthButtonState();
}

class _MonthButtonState extends State<MonthButton> {


  // int monthNameToInt(String monthName) {
  //   final dateTime = DateFormat('MMM').parse(monthName);
  //   return dateTime.month;
  // }

  // String? selectedMonth;

  List<String> months = [
    'JAN',
    'FEB',
    'MAR',
    'APR',
    'MAY',
    'JUN',
    'JUL',
    'AUG',
    'SEP',
    'OCT',
    'NOV',
    'DEC'
  ];

  @override
  Widget build(BuildContext context) {

     double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    final myTheme = Theme.of(context).colorScheme;
    return Container(
       width: screenWidth * 0.85,
      // width: 300,
      child: Column(
        children: List.generate(4, (rowIndex) {
          return Row(
            children: List.generate(3, (columnIndex) {
              int monthIndex = rowIndex * 3 + columnIndex;
              if (monthIndex >= months.length) {
                return Expanded(child: Container());
              }
              return Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        selectedMonth = months[monthIndex];
                        // int selectedMonthNumber = monthNameToInt(selectedMonth!);
                      });
                    },
                    child: Text(months[monthIndex],
                        style: TextStyle(fontSize: 13, color: Colors.white)),

                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(5.0), // Make it rectangle
                      ),
                      foregroundColor: selectedMonth == months[monthIndex]
                          ? myTheme.error
                          : myTheme.primary,
                      backgroundColor: selectedMonth == months[monthIndex]
                      ? myTheme.error
                      : myTheme.primary,

                      side: BorderSide(
                        color: selectedMonth == months[monthIndex]
                            ? myTheme.error
                            : myTheme.primary,
                      ),
                    ),
                  ),
                ),
              );
            }),
          );
        }),
      ),

    );
  }
}



final _totalHours = TextEditingController(); 
final _totalNVD = TextEditingController();
final _formsemiHours = TextEditingController();
final _totalsemiHours = TextEditingController();
final _backSemi = TextEditingController();
final _frontSemi = TextEditingController();
final _nvsSemi = TextEditingController();
final _nvgSemi = TextEditingController();
final _nunaidedSemi = TextEditingController();
final _hwSemi= TextEditingController();
final _simtotalSemi = TextEditingController();
final _bssimSemi = TextEditingController();
final _fssimSemi = TextEditingController();
final _gcoftSemi = TextEditingController();
final _totalKey = GlobalKey<FormState>();
final _semiKey = GlobalKey<FormState>();

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
         height: screenHeight * 0.05, // 10% of screen height
         child: TextFormField(
           textAlign: TextAlign.left,
           style: TextStyle(fontSize: 14),
           decoration: InputDecoration(
             isDense: true,
             hintText: " Hours",
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


String? selectedFac;
class facAviator extends StatefulWidget {
  const facAviator({Key? key}) : super(key: key);

  @override
  _facAviatorState createState() => _facAviatorState();
}

class _facAviatorState extends State<facAviator> {
  // String? selectedMonth;

  List<String> fac = [
    'FAC 1',
    'FAC 2',
    'FAC 3',

  ];

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    final myTheme = Theme.of(context).colorScheme;
    return Container(
      width: screenWidth * 0.85,
      // width: 300,
      child: Column(
        children: List.generate(1, (rowIndex) {
          return Row(
            children: List.generate(3, (columnIndex) {
              int facAvi = rowIndex * 3 + columnIndex;
              if (facAvi >= fac.length) {
                return Expanded(child: Container());
              }
              return Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        selectedFac = fac[facAvi];
                      });
                    },
                    child: Text(fac[facAvi],
                        style: TextStyle(fontSize: 13, color: Colors.white)),

                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(5.0), // Make it rectangle
                      ),
                      foregroundColor: selectedFac == fac[facAvi]
                          ? myTheme.error
                          : myTheme.primary,
                      backgroundColor: selectedFac == fac[facAvi]
                          ? myTheme.error
                          : myTheme.primary,

                      side: BorderSide(
                        color: selectedFac == fac[facAvi]
                            ? myTheme.error
                            : myTheme.primary,
                      ),
                    ),
                  ),
                ),
              );
            }),
          );
        }),
      ),

    );
  }
}


Future initialOnboardData() async {
  final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('users');
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final uid = user?.uid;

  final onboardData = {
    "Airframe": selectedAirframe,
    "Birth Month": selectedMonth,
    "FAC Level": selectedFac,
  };

  await _usersCollection.doc(uid).update(onboardData).then((value) => print("Data Added"))
      .catchError((error) => print("Failed to add data: $error"));

}




