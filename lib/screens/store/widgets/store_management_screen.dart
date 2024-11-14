// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../Contollers/providers/auth_provider.dart';
// import '../../Contollers/providers/store_provider.dart';
//
//
// class StoreManagementScreen extends StatefulWidget {
//   @override
//   _StoreManagementScreenState createState() => _StoreManagementScreenState();
// }
//
// class _StoreManagementScreenState extends State<StoreManagementScreen> {
//   final TextEditingController _storeNameController = TextEditingController();
//   final TextEditingController _locationController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     final storeProvider = Provider.of<StoreProvider>(context);
//     final authProvider = Provider.of<AuthProvider>(context);
//
//     return Scaffold(
//       appBar: AppBar(title: const Text("Store Management")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _storeNameController,
//               decoration: const InputDecoration(labelText: "Store Name"),
//             ),
//             TextField(
//               controller: _locationController,
//               decoration: const InputDecoration(labelText: "Location"),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 await storeProvider.addStore(
//                   authProvider.user!.uid,
//                   _storeNameController.text,
//                   _locationController.text,
//                 );
//                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Store added successfully!")));
//               },
//               child: const Text("Add Store"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
