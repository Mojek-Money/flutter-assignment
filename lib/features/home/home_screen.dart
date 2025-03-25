import 'package:finvu_test/features/finvu/mobile_number_confirmation_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> selectedBanks = [];

  List<dynamic> bankList = [
    {
      "_id": "1",
      "fipId": "AXIS001",
      "name": "Axis Bank",
      "fiTypes": ["DEPOSIT"],
      "status": "ACTIVE",
      "icon":
          "https://s3.ap-south-1.amazonaws.com/mojek/icons/banks/axis-bank-v2.png"
    },
    {
      "_id": "2",
      "fipId": "fiplive@indusind",
      "name": "IndusInd Bank Ltd.",
      "fiTypes": ["DEPOSIT", "TERM_DEPOSIT", "RECURRING_DEPOSIT"],
      "status": "ACTIVE",
      "icon":
          "https://s3.ap-south-1.amazonaws.com/mojek/icons/banks/indusind-bank-v2.png"
    },
    {
      "_id": "3",
      "fipId": "HDFC-FIP",
      "name": "HDFC Bank",
      "fiTypes": ["DEPOSIT"],
      "status": "ACTIVE",
      "icon":
          "https://s3.ap-south-1.amazonaws.com/mojek/icons/banks/hdfc-bank-v2.png"
    },
    {
      "_id": "4",
      "fipId": "ICICI-FIP",
      "name": "ICICI Bank",
      "fiTypes": ["DEPOSIT"],
      "status": "ACTIVE",
      "icon":
          "https://s3.ap-south-1.amazonaws.com/mojek/icons/banks/icici-bank-v2.png"
    },
    {
      "_id": "5",
      "fipId": "IDFCFirstBank-FIP",
      "name": "IDFC First Bank",
      "fiTypes": ["DEPOSIT"],
      "status": "ACTIVE",
      "icon":
          "https://s3.ap-south-1.amazonaws.com/mojek/icons/banks/idfc-first-bank-v2.png"
    },
  ];

  void toggleSelection(bank) {
    setState(() {
      if (selectedBanks.contains(bank)) {
        selectedBanks.remove(bank);
      } else {
        selectedBanks.add(bank);
      }
    });
  }

  void navigateToFinvu() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FinvuMobileNumberConfirmationScreen(
                  fipIdList: selectedBanks
                      .map((e) => BankConnectionItem(
                          id: e['_id'],
                          fipId: e['fipId'],
                          name: e['name'],
                          fiTypes: e['fiTypes'],
                          status: e['status'],
                          icon: e['name']))
                      .toList(),
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.white,
            )),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: bankList.length,
              itemBuilder: (context, index) {
                final bank = bankList[index];
                final isSelected = selectedBanks.contains(bank);
                return ListTile(
                  leading: Image.network(bank['icon'], width: 40, height: 40),
                  title: Text(bank['name']),
                  trailing: Icon(
                    isSelected
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color: isSelected ? Colors.green : Colors.grey,
                  ),
                  onTap: () => toggleSelection(bank),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: selectedBanks.isNotEmpty
                  ? () {
                      // Handle the selection logic here
                      print("Selected Banks: $selectedBanks");
                      navigateToFinvu();
                    }
                  : null,
              child: const Text("Continue to Connect"),
            ),
          )
        ],
      ),
    );
  }
}
