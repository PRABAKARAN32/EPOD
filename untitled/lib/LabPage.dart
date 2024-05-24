import 'package:flutter/material.dart';

class BloodTestReportApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blood Test Report',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BloodTestForm(),
    );
  }
}

class BloodTestForm extends StatefulWidget {
  @override
  _BloodTestFormState createState() => _BloodTestFormState();
}

class _BloodTestFormState extends State<BloodTestForm> {
  final _formKey = GlobalKey<FormState>();

  // Define controllers for input fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _hemoglobinController = TextEditingController();
  final TextEditingController _wbcController = TextEditingController();
  final TextEditingController _plateletsController = TextEditingController();

  String insulinTestResult = "";
  String urineTestResult = "";

  void _showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text('Select Test'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InsulinTestForm(
                      onSubmit: (result) {
                        setState(() {
                          insulinTestResult = result;
                        });
                      },
                    ),
                  ),
                );
              },
              child: Text('Insulin Test'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UrineTestForm(
                      onSubmit: (result) {
                        setState(() {
                          urineTestResult = result;
                        });
                      },
                    ),
                  ),
                );
              },
              child: Text('Urine Test'),
            ),
          ],
        );
      },
    );
  }

  void _showSummary(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SummaryPage(
          name: _nameController.text,
          age: _ageController.text,
          hemoglobin: _hemoglobinController.text,
          wbc: _wbcController.text,
          platelets: _plateletsController.text,
          insulinTestResult: insulinTestResult,
          urineTestResult: urineTestResult,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Test Report'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showAddDialog(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your age';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _hemoglobinController,
                decoration: InputDecoration(labelText: 'Hemoglobin (g/dL)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your hemoglobin level';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _wbcController,
                decoration: InputDecoration(labelText: 'WBC Count (cells/mcL)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your WBC count';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _plateletsController,
                decoration: InputDecoration(labelText: 'Platelets (cells/mcL)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your platelets count';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Process data
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Report Submitted'),
                          content: Text('Name: ${_nameController.text}\n'
                              'Age: ${_ageController.text}\n'
                              'Hemoglobin: ${_hemoglobinController.text} g/dL\n'
                              'WBC Count: ${_wbcController.text} cells/mcL\n'
                              'Platelets: ${_plateletsController.text} cells/mcL'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text('Submit'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _showSummary(context);
                  }
                },
                child: Text('Show Summary'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InsulinTestForm extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _beforeFastingInsulinController =
      TextEditingController();
  final TextEditingController _afterFastingInsulinController =
      TextEditingController();
  final Function(String) onSubmit;

  InsulinTestForm({required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insulin Test Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _beforeFastingInsulinController,
                decoration:
                    InputDecoration(labelText: 'Before Fasting Insulin Level'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _afterFastingInsulinController,
                decoration:
                    InputDecoration(labelText: 'After Fasting Insulin Level'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Process insulin test data
                  String result = 'Name: ${_nameController.text}\n'
                      'Age: ${_ageController.text}\n'
                      'Before Fasting Insulin Level: ${_beforeFastingInsulinController.text}\n'
                      'After Fasting Insulin Level: ${_afterFastingInsulinController.text}';
                  onSubmit(result);
                  Navigator.of(context).pop();
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UrineTestForm extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _urineTestDetailsController =
      TextEditingController();
  final Function(String) onSubmit;

  UrineTestForm({required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Urine Test Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _urineTestDetailsController,
                decoration: InputDecoration(labelText: 'Urine Test Details'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Process urine test data
                  String result = 'Name: ${_nameController.text}\n'
                      'Age: ${_ageController.text}\n'
                      'Urine Test Details: ${_urineTestDetailsController.text}';
                  onSubmit(result);
                  Navigator.of(context).pop();
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SummaryPage extends StatelessWidget {
  final String name;
  final String age;
  final String hemoglobin;
  final String wbc;
  final String platelets;
  final String insulinTestResult;
  final String urineTestResult;

  SummaryPage({
    required this.name,
    required this.age,
    required this.hemoglobin,
    required this.wbc,
    required this.platelets,
    required this.insulinTestResult,
    required this.urineTestResult,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Summary Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            _buildTopic("Blood Test Report"),
            SizedBox(height: 10),
            _buildInfo("Name", name),
            _buildInfo("Age", age),
            _buildInfo("Hemoglobin", "$hemoglobin g/dL"),
            _buildInfo("WBC Count", "$wbc cells/mcL"),
            _buildInfo("Platelets", "$platelets cells/mcL"),
            SizedBox(height: 20),
            _buildTopic("Insulin Test"),
            SizedBox(height: 10),
            _buildInfo("Insulin Test Result", insulinTestResult),
            SizedBox(height: 20),
            _buildTopic("Urine Test"),
            SizedBox(height: 10),
            _buildInfo("Urine Test Result", urineTestResult),
          ],
        ),
      ),
    );
  }

  Widget _buildTopic(String topic) {
    return Text(
      topic,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
      ),
    );
  }

  Widget _buildInfo(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(value),
          ),
        ],
      ),
    );
  }
}

//TODO :: to generate a pdf a api should be included and then the report will be generated automatically
