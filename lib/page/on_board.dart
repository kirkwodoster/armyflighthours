import 'package:flutter/material.dart';

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
              children: [RadioExample()],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [FloatInputForm()],
            ),
            Stack(alignment: Alignment.center, children: [DateInput()])
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

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        OutlinedButton.icon(
          onPressed: () {},
          icon: Icon(Icons.home),
          label: Text('Home'),
        ),
        OutlinedButton.icon(
          onPressed: () {},
          icon: Icon(Icons.settings),
          label: Text('Settings'),
        ),
        OutlinedButton.icon(
          onPressed: () {},
          icon: Icon(Icons.info),
          label: Text('Info'),
        ),
      ],
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Form(
      key: _formKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: screenWidth * 0.25, // 80% of screen width
            height: screenHeight * 0.25, // 10% of screen height
            child: TextFormField(
              decoration: InputDecoration(hintText: "Total Hours"),
              keyboardType: TextInputType.number,
              controller: _firstController,
              validator: (value) {
                if (double.tryParse(value ?? '') == null) {
                  return 'Please enter a valid float';
                }
                return null;
              },
            ),
          ),
          //SizedBox(height: 20),
          Container(
            width: screenWidth * 0.25,
            height: screenHeight * 0.25,
            child: TextFormField(
              decoration: InputDecoration(hintText: "Total NVS"),
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

class DateInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InputDatePickerFormField(
            fieldLabelText: 'Enter Birthdate',
            firstDate: DateTime(2015, 8),
            lastDate: DateTime.now(),
            autofocus: true,
          ),
        ),
      ),
    );
  }
}
