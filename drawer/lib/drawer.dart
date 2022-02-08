import 'package:flutter/material.dart';

class drawer extends StatefulWidget {
  const drawer({Key? key}) : super(key: key);

  @override
  _drawerState createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  static const String routeName1 = '/drawer';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Custom Drawer"),
        centerTitle: true,
        // leading: IconButton(
        //   onPressed: (){},
        //   icon: const Icon(Icons.search),
        // ),
      ),
      drawer: customDrawer(),
    );
  }

  Drawer customDrawer() {
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text("Muhammad ahmer khan"),
            accountEmail: Text("mahmerk99@gmail.com"),
            currentAccountPicture: CircleAvatar(
              child: Text("A"),
            ),
          ),
          const ListTile(
            title: Text("Text 1"),
            subtitle: Text("subtitle 1"),
            leading: Icon(Icons.search),
          ),
          const Divider(),
          const ListTile(
            title: Text("Text 2"),
            subtitle: Text("subtitle 2"),
            leading: Icon(Icons.search),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              Navigator.pop(context);
            },
            title: const Text("Text 3"),
            subtitle: const Text("subtitle 3"),
            leading: const Icon(Icons.search),
          ),
          const Divider(),
          const ListTile(
            title: Text("Text 4"),
            subtitle: Text("subtitle 4"),
            leading: Icon(Icons.search),
          ),
          const ListTile(
            title: Text("version 0.0.1"),
          )
        ],
      ),
    );
  }
}
