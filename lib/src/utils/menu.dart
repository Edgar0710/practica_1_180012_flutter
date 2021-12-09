import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: null,
            // child: Text('Drawer Header'),
          ),
          Card(
            child: ListTile(
              title: const Text('Citas'),
              onTap: () {
                // Update the state of the app.
                // ...
                Navigator.pushNamed(context, 'home');
              },
            ),
          ),
          // Card(
          //   child: ListTile(
          //     title: const Text('Maps'),
          //     onTap: () {
          //       // Update the state of the app.
          //       // ...
          //       Navigator.pushNamed(context, 'Maps');
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
