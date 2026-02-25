import 'package:flutter/material.dart';
import 'login_page.dart';
import 'dart:math';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _logout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (route) => false,
    );
  }

  List<Map<String, dynamic>> _generateRandomPatients() {
    final List<String> names = [
      'Adit', 'Budi', 'Cici', 'Dewi', 'Eka', 'Fani', 'Gilang', 'Hana', 'Indra', 'Joko'
    ];
    final random = Random();
    final patients = <Map<String, dynamic>>[];
    final usedIndexes = <int>{};
    while (patients.length < 5) {
      int idx = random.nextInt(names.length);
      if (!usedIndexes.contains(idx)) {
        usedIndexes.add(idx);
        patients.add({
          'name': names[idx],
          'age': 1 + random.nextInt(12), // age 1-12
        });
      }
    }
    return patients;
  }

  @override
  Widget build(BuildContext context) {
    final patients = _generateRandomPatients();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medica Home'),
        backgroundColor: const Color(0xFF2196F3),
        actions: [
          PopupMenuButton<int>(
            icon: const Icon(Icons.account_circle, size: 32),
            onSelected: (value) {
              if (value == 1) {
                _logout(context);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem<int>(
                value: 1,
                child: ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            const Text(
              'Welcome to Medica!\nYou are logged in.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            const Text(
              'Patients:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                itemCount: patients.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final patient = patients[index];
                  return ListTile(
                    leading: const Icon(Icons.child_care, color: Color(0xFF2196F3)),
                    title: Text(patient['name'], style: const TextStyle(fontSize: 18)),
                    subtitle: Text('Age: ${patient['age']}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
