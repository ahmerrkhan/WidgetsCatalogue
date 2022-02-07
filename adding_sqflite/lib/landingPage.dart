import 'package:adding_sqflite/sql_helper.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class landingPage extends StatefulWidget {
  const landingPage({Key? key}) : super(key: key);

  @override
  _landingPageState createState() => _landingPageState();
}

class _landingPageState extends State<landingPage> {
  //List of all journals
  List<Map<String, dynamic>> _journals = [];
  bool _isLoading = true;

  void _refreshJournals() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshJournals();
  }

  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();

  //Function to _addItem()

  Future<void> _addItem() async {
    await SQLHelper.createItem(_title.text, _description.text);
    _refreshJournals();
  }

  //Function to _updateItem()
  Future<void> _updateItem(int id) async {
    await SQLHelper.updateItem(id, _title.text, _description.text);
    _refreshJournals();
  }

  //function to show form
  void _showForm(int? id) async {
    if (id != null) {
      final existingJournal =
          _journals.firstWhere((element) => element['id'] == id);
      _title.text = existingJournal['title'];
      _description.text = existingJournal['description'];
    }

    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.only(
                top: 15,
                right: 15,
                left: 15,
                bottom: MediaQuery.of(context).viewInsets.bottom + 120),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  controller: _title,
                  decoration: const InputDecoration(hintText: 'Title'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _description,
                  decoration: const InputDecoration(hintText: 'Description'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (id == null) {
                      await _addItem();
                    }
                    if (id != null) {
                      await _updateItem(id);
                    }

                    _title.text = '';
                    _description.text = '';
                    Navigator.pop(context);
                  },
                  child: Text(id == null ? "Create New" : "Update"),
                ),
              ],
            ),
          );
        });
  }

  void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Successfully deleted note")));
    _refreshJournals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[200],
        centerTitle: true,
        title: const Text("Hello World"),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
          itemCount: _journals.length,
          itemBuilder: (context, index) {
              return Card(
                color: Colors.orange[200],
                margin: const EdgeInsets.all(15),
                child: ListTile(
                  title: Text(_journals[index]['title']),
                  subtitle: Text(_journals[index]['description']),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => _showForm(_journals[index]['id']),
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteItem(_journals[index]['id']),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _showForm(null);
        },
      ),
    );
  }
}
