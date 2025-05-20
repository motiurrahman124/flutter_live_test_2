import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final List<Map<String, String>> _contacts = [];

  void _addContact() {
    final name = _nameController.text.trim();
    final number = _numberController.text.trim();
    if (name.isNotEmpty && number.isNotEmpty) {
      setState(() {
        _contacts.add({'name': name, 'number': number});
        _nameController.clear();
        _numberController.clear();
      });
    }
  }

  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Confirmation"),
            content: const Text("Are you sure for Delete?"),
            actions: [
              IconButton(
                icon: const Icon(Icons.no_cell, color: Colors.blue, size: 20,),
                onPressed: () => Navigator.of(context).pop(),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.blue),
                onPressed: () {
                  setState(() {
                    _contacts.removeAt(index);
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Contact List",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _numberController,
              decoration: const InputDecoration(
                hintText: 'Number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12.0),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _addContact,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text("Add", style: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                itemCount: _contacts.length,
                itemBuilder: (context, index) {
                  final contact = _contacts[index];
                  return GestureDetector(
                    onLongPress: () => _confirmDelete(index),
                    child: Container(

                      margin: EdgeInsets.only(top: 5.0),
                      decoration: BoxDecoration(color: Colors.grey.shade200, border: Border.all(color: Colors.grey.shade300)),
                      child: ListTile(
                        leading: const Icon(Icons.person, size: 32, color: Colors.brown,),
                        title: Text(
                          contact['name'] ?? '',
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(contact['number'] ?? ''),
                        trailing: const Icon(Icons.phone, color: Colors.blue, size: 28),
                      ),
                    ),
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
