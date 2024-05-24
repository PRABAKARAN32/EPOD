import 'package:flutter/material.dart';
import 'LabPage.dart';

void main() {
  runApp(MedicalClinicApp());
}

class Medicine {
  final String name;
  final String brand;
  final int quantity;
  final double price;
  final String gst;
  final String expiryDate;
  final int availableStock;
  final String batchID;

  Medicine({
    required this.name,
    required this.brand,
    required this.quantity,
    required this.price,
    required this.gst,
    required this.expiryDate,
    required this.availableStock,
    required this.batchID,
  });
}

class MedicalClinicApp extends StatelessWidget {
  final List<Medicine> medicines = [
    Medicine(
      name: "Paracetamol",
      brand: "ABC Pharmaceuticals",
      quantity: 10,
      price: 79.08,
      gst: "5%",
      expiryDate: "2024-12-31",
      availableStock: 100,
      batchID: "ABC123",
    ),
    Medicine(
      name: "Ibuprofen",
      brand: "XYZ Pharmaceuticals",
      quantity: 20,
      price: 100.12,
      gst: "5%",
      expiryDate: "2025-06-30",
      availableStock: 150,
      batchID: "XYZ456",
    ),
    // Add more medicines as needed
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
        hintColor: Colors.green,
        scaffoldBackgroundColor: Colors.grey[200],
      ),
      home: MedicalClinicHomePage(),
    );
  }
}

class MedicalClinicHomePage extends StatefulWidget {
  @override
  _MedicalClinicHomePageState createState() => _MedicalClinicHomePageState();
}

class _MedicalClinicHomePageState extends State<MedicalClinicHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? 'Bill Report' : 'Lab'),
      ),
      body: _selectedIndex == 0 ? BillReportPage() : LabPage(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.article_outlined),
            label: 'Bill',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.science_outlined),
            label: 'Lab',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class BillReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: MedicalClinicApp().medicines.length,
      itemBuilder: (context, index) {
        final Medicine medicine = MedicalClinicApp().medicines[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MedicineDetailsPage(
                  medicine: medicine,
                  personName: "John Doe", // Replace with actual person's name
                ),
              ),
            );
          },
          child: Card(
            elevation: 3,
            margin: EdgeInsets.all(8),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Person Name: John Doe',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Medicine Name: ${medicine.name}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Text('Brand: ${medicine.brand}'),
                  Text('Quantity: ${medicine.quantity}'),
                  Text('Price: \₹${medicine.price.toStringAsFixed(2)}'),
                  Text('GST: ${medicine.gst}'),
                  Text('Expiry Date: ${medicine.expiryDate}'),
                  Text('Available Stock: ${medicine.availableStock}'),
                  Text('Batch ID: ${medicine.batchID}'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class LabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BloodTestReportApp();
    //Center(
    //   child: Text(
    //     'Lab Page',
    //     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    //   ),
    //);
  }
}

class MedicineDetailsPage extends StatefulWidget {
  final Medicine medicine;
  final String personName;

  MedicineDetailsPage({required this.medicine, required this.personName});

  @override
  _MedicineDetailsPageState createState() => _MedicineDetailsPageState();
}

class _MedicineDetailsPageState extends State<MedicineDetailsPage> {
  late TextEditingController _quantityController;

  @override
  void initState() {
    super.initState();
    _quantityController =
        TextEditingController(text: widget.medicine.quantity.toString());
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medicine Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Person Name: ${widget.personName}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Medicine Name: ${widget.medicine.name}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(height: 12),
            Text('Brand: ${widget.medicine.brand}',
                style: TextStyle(fontSize: 16)),
            TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Quantity',
                fillColor: Theme.of(context).scaffoldBackgroundColor,
                filled: true,
              ),
            ),
            SizedBox(height: 12),
            Text('Price: \₹${widget.medicine.price.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 16)),
            Text('GST: ${widget.medicine.gst}', style: TextStyle(fontSize: 16)),
            Text('Expiry Date: ${widget.medicine.expiryDate}',
                style: TextStyle(fontSize: 16)),
            Text('Available Stock: ${widget.medicine.availableStock}',
                style: TextStyle(fontSize: 16)),
            Text('Batch ID: ${widget.medicine.batchID}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                double totalPrice = widget.medicine.price *
                    double.parse(_quantityController.text);
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Total Amount'),
                      content: Text(
                          'Total Price: \₹${totalPrice.toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 16)),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
