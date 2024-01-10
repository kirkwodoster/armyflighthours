import 'package:firebase_auth_verify_email/army_aircraft_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


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
  Widget build(BuildContext context) => Scaffold(
    
      body: Container(
        //height: double.infinity,
        //width: double.infinity,
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
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
              children: [
                Text('Select Airframe', style:TextStyle(fontSize: 25)),
                SizedBox(height: 20),
                RadioExample(),
                SizedBox(height: 20),
                
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text('Input Total Hours and NVS'),
                SizedBox(height: 20),
                FloatInputForm(),
               SizedBox(height: 10),
                Text('Select Date of Birth'),
                SizedBox(height: 20),
                MonthButton(),
                SizedBox(height: 20),],
                
            ),
            // Stack(alignment: Alignment.center, children: [DateInput()])
            Column(
              children: [
                
                // TextField(
                //   keyboardType: TextInputType.number,
                //   inputFormatters: [
                //     DOBFormatter(),
                //   ],
                // ),
              ],
            )
          ],
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
                      print(_RadioExampleState()._character.toString());
                      ;
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
                        child: const Text('Next'),
                        onPressed: () => controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          
                        ),
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
                        if (_formKey.currentState!.validate() && selectedMonth != null) {
                          controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                          print(selectedMonth.toString());
                        }
                      },
                      ),
                      
                    ],
                  ),
                ));
}

enum SingingCharacter { Apache, Blackhawk, Chinook }

class RadioExample extends StatefulWidget {
  @override
  _RadioExampleState createState() => _RadioExampleState();
}

class _RadioExampleState extends State<RadioExample> {
  SingingCharacter? _character = SingingCharacter.Apache;
  String? selectedButton;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    final myTheme = Theme.of(context).colorScheme;
    return Container(
      width: screenWidth * 0.7,
      // height: screenHeight * 0.15,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
         Container(
          width: 250,
          height: 200,
    child: TextButton(
   onPressed: () {
       setState(() {
           selectedButton = 'Apache';
       });
   },
   child: Column(
       children: [
           Padding(
               padding: const EdgeInsets.only(right: 80, top: 30),
               child: Icon(ArmyAircraft.apache, color: selectedButton == 'Apache' ? myTheme.error : myTheme.primary, size: 140.0),
           ),
           SizedBox(height: 10,),
       ],
   ),
   style: ButtonStyle(
       
       foregroundColor: MaterialStateProperty.resolveWith(
           (Set<MaterialState> states) {
               if (states.contains(MaterialState.pressed)) {
                  return selectedButton == 'Blackhawk' ? myTheme.error : myTheme.primary;
               } else {
                  return selectedButton == 'Blackhawk' ? myTheme.error : myTheme.primary;
               }
           }),
   ),
),

  ),

	SizedBox(height: 0),
  Container(width: 250,
          height: 200,
    child: TextButton(
     onPressed: () {
     setState(() {
     selectedButton = 'Blackhawk';
     });
     },
     
     child: Column(
    //  mainAxisSize: MainAxisSize.min,
     children: [
     Padding(
       padding: const EdgeInsets.only(right: 50),
       child: Icon(ArmyAircraft.blackhawk, color: selectedButton == 'Blackhawk' ? myTheme.error : myTheme.primary, size: 200  ),
     ),
     SizedBox(height: 0,),
    //  Text('Blackhawk', style: TextStyle(fontSize: 20, color: selectedButton == 'Blackhawk' ? myTheme.error : myTheme.primary)),
     ],
     ),
     style: ButtonStyle(
    
     foregroundColor: MaterialStateProperty.resolveWith(
     (Set<MaterialState> states) {
     if (states.contains(MaterialState.pressed)) {
       return selectedButton == 'Blackhawk' ? myTheme.error : myTheme.primary;
     } else {
       return selectedButton == 'Blackhawk' ? myTheme.error : myTheme.primary;
     }
     }),
     ),
    ),
  ),

SizedBox(height: 0),



 Container(width: 250,
          height: 200,
    child: TextButton(
     onPressed: () {
     setState(() {
     selectedButton = 'Chinook';
     });
     },
     
     child: Column(
    //  mainAxisSize: MainAxisSize.min,
     children: [
     Padding(
       padding: const EdgeInsets.only(right: 100, top: 20),
       child: Icon(ArmyAircraft.chinook, color: selectedButton == 'Chinook' ? myTheme.error : myTheme.primary, size: 125),
     ),SizedBox(height: 10,),
    //  Text('Chinook', style: TextStyle(fontSize: 20, color: selectedButton == 'Chinook' ? myTheme.error : myTheme.primary)),
     ],
     ),
     style: ButtonStyle(
    
     foregroundColor: MaterialStateProperty.resolveWith(
     (Set<MaterialState> states) {
     if (states.contains(MaterialState.pressed)) {
       return selectedButton == 'Chinook' ? myTheme.error : myTheme.primary;
     } else {
       return selectedButton == 'Chinook' ? myTheme.error : myTheme.primary;
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
final _formKey = GlobalKey<FormState>();
class FloatInputForm extends StatefulWidget {
  @override


  _FloatInputFormState createState() => _FloatInputFormState();
}

class _FloatInputFormState extends State<FloatInputForm> {
  final _firstController = TextEditingController();
  final _secondController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    
    final myTheme = Theme.of(context).colorScheme;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Form(
      key: _formKey,
      child: Container(
        width: screenWidth * 0.7,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
               width: screenWidth * 0.45, // 80% of screen width
              height: screenHeight * 0.02, // 10% of screen height
              
              child: Text('Total Hours')),
              SizedBox(height:3),
            Container(
              width: screenWidth * 0.45, // 80% of screen width
              height: screenHeight * 0.05, // 10% of screen height
              child: TextFormField(
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  isDense: true,
                  hintText: "  Hours",
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
                controller: _firstController,
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
            Container(
              width: screenWidth * 0.45, // 80% of screen width
              height: screenHeight * 0.02, // 10% of screen height
              child: Text('Total NVS')),
              SizedBox(height:3),
            Container(
              width: screenWidth * 0.45,
              height: screenHeight * 0.05,
              child: TextFormField(
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  isDense: true,
                  hintText: "  Hours",
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
                controller: _secondController,
                validator: (value) {
                 double? parsedValue = double.tryParse(value!);
                    if (parsedValue == null || parsedValue > 50000) {
                      return 'Please enter a valid number';
                    }
                    return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AutoDatePicker extends StatefulWidget {
  @override
  _AutoDatePickerState createState() => _AutoDatePickerState();
}

class _AutoDatePickerState extends State<AutoDatePicker> {
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => selectDate());
  }

  Future<void> selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1940, 8),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(); // Replace with your actual UI
  }
}

class DOBFormatter extends TextInputFormatter {
  final sampleValue = '01/01/2000';

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > oldValue.text.length) {
      // If the new value length exceeds the sample value length
      // return the old value;
      if (newValue.text.length > sampleValue.length) {
        return oldValue;
      }

      // Check if the recently entered character is a digit or not.
      final lastEnteredLetter = newValue.text[newValue.text.length - 1];
      if (!RegExp(r'[0-9]').hasMatch(lastEnteredLetter)) {
        return oldValue;
      }

      // If the next index place is a separator, then modify the
      // text editing value.
      if (sampleValue.length != newValue.text.length &&
          sampleValue[newValue.text.length] == '/') {
        final lastTwoDigits = newValue.text.substring(newValue.text.length - 2);
        String? modifiedString;

        if (newValue.text.length == 2) {
          int value = int.parse(lastTwoDigits);
          if (value > 31) {
            value = value ~/ 10;
            modifiedString = '0$value';
          }
        }

        if (newValue.text.length == 5) {
          int value = int.parse(lastTwoDigits);
          if (value > 12) {
            value = value ~/ 10;
            modifiedString =
                '${newValue.text.substring(0, newValue.text.length - 2)}0$value';
          }
        }

        return TextEditingValue(
          text: '${modifiedString ?? newValue.text}/',
          selection:
              TextSelection.collapsed(offset: newValue.selection.end + 1),
        );
      }
    }

    return newValue;
  }
}



String? selectedMonth;
class MonthButton extends StatefulWidget {
  const MonthButton({Key? key}) : super(key: key);

  @override
  _MonthButtonState createState() => _MonthButtonState();
}

class _MonthButtonState extends State<MonthButton> {
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
       width: screenWidth * 0.45,
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
                      });
                    },
                    child: Text(months[monthIndex],
                        style: TextStyle(fontSize: 13)),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(5.0), // Make it rectangle
                      ),
                      foregroundColor: selectedMonth == months[monthIndex]
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


