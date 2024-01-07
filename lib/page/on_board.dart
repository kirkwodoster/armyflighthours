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
                Text('Select Aircraft Type'),
                SizedBox(height: 20),
                RadioExample(),
                SizedBox(height: 20),
                Text('Input Total Hours and NVS'),
                SizedBox(height: 20),
                FloatInputForm(),
                // SizedBox(height: 10),
                Text('Select Date of Birth'),
                SizedBox(height: 20),
                MonthButton(),
                SizedBox(height: 20),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [],
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
                        onPressed: () => controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        ),
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
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    final myTheme = Theme.of(context).colorScheme;
    return Container(
      width: screenWidth * 0.7,
      // height: screenHeight * 0.15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            width: 90,
            height: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Material(
                color: myTheme.primary,
                //shape: CircleBorder(),
                elevation: 8,
                borderRadius: BorderRadius.circular(15),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      selectedButton = 'Apache';
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.network(
                          'https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1171&q=80'), // Add your image URL here
                      Text(
                        'Apache',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          OutlinedButton.icon(
            onPressed: () {
              setState(() {
                selectedButton = 'Blackhawk';
              });
            },
            icon: Icon(Icons.flight_outlined),
            label: Text('Blackhawk'),
            style: ButtonStyle(
              side: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> states) {
                if (selectedButton == 'Blackhawk') {
                  return BorderSide(color: myTheme.error);
                } else {
                  return BorderSide(color: myTheme.primary);
                }
              }),
              foregroundColor: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> states) {
                if (selectedButton == 'Blackhawk') {
                  return myTheme.error;
                } else {
                  return myTheme.primary;
                }
              }),
            ),
          ),
          OutlinedButton.icon(
            onPressed: () {
              setState(() {
                selectedButton = 'Chinook';
              });
            },
            icon: Icon(Icons.flight_outlined),
            label: Text('Chinook'),
            style: ButtonStyle(
              side: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> states) {
                if (selectedButton == 'Chinook') {
                  return BorderSide(color: myTheme.error);
                } else {
                  return BorderSide(color: myTheme.primary);
                }
              }),
              foregroundColor: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> states) {
                if (selectedButton == 'Chinook') {
                  return myTheme.error;
                } else {
                  return myTheme.primary;
                }
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class FloatInputForm extends StatefulWidget {
  @override
  _FloatInputFormState createState() => _FloatInputFormState();
}

class _FloatInputFormState extends State<FloatInputForm> {
  final _firstController = TextEditingController();
  final _secondController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context).colorScheme;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Form(
      key: _formKey,
      child: Container(
        width: screenWidth * 0.7,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: screenWidth * 0.25, // 80% of screen width
              height: screenHeight * 0.15, // 10% of screen height
              child: TextFormField(
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  isDense: true,
                  hintText: "Total Hours",
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
                  if (value != null && double.parse(value) < 50000) {
                    return 'Please enter a valid float';
                  }
                  return null;
                },
              ),
            ),
            Container(
              width: screenWidth * 0.25,
              height: screenHeight * 0.15,
              child: TextFormField(
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  isDense: true,
                  hintText: "Total NVS",
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
                  if (double.tryParse(value ?? '') == null) {
                    return 'Please enter a valid float';
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

class MonthButton extends StatefulWidget {
  const MonthButton({Key? key}) : super(key: key);

  @override
  _MonthButtonState createState() => _MonthButtonState();
}

class _MonthButtonState extends State<MonthButton> {
  String? selectedMonth;

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
    final myTheme = Theme.of(context).colorScheme;
    return Container(
      width: 300,
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
