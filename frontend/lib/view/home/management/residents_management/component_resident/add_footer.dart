// import 'package:flutter/material.dart';
// import '../../../../../common/date_filter.dart';
// import '../../../../../models/resident_info.dart';
//
// class AddFooter extends StatefulWidget {
//   const AddFooter({super.key, required this.addNewResident});
//
//   final Function addNewResident;
//
//   @override
//   State<AddFooter> createState() => _AddFooterState();
// }
//
// class _AddFooterState extends State<AddFooter> {
//   final DateFilterPopup _dateFilterPopup = DateFilterPopup(
//     onDateSelected: (selectedDate) {
//       print('Selected date: $selectedDate');
//       // Xử lý ngày đã chọn
//     },
//   );
//
//   String? _selectedStatus;
//
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController dobController = TextEditingController();
//   final TextEditingController idController = TextEditingController();
//   final TextEditingController ageController = TextEditingController();
//   final TextEditingController roomController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//
//   void handleOnClick() {
//     final name = nameController.text.trim();
//     final dob = dobController.text.trim();
//     var id = idController.text.trim();
//     final age = int.tryParse(ageController.text.trim()) ?? 0;
//     final status = _selectedStatus;
//     final room = int.tryParse(roomController.text.trim()) ?? 0;
//     final phone = phoneController.text.trim();
//
//     if (id.isEmpty) {
//       id = DateTime.now().toString();
//     }
//
//     final resident = ResidentInfo(
//       full_name: name,
//       date_of_birth: dob,
//       id_number: id,
//       age: age,
//       room: room,
//       phone_number: phone,
//       status: status,
//     );
//
//     widget.addNewResident(resident);
//
//     nameController.clear();
//     dobController.clear();
//     idController.clear();
//     ageController.clear();
//     roomController.clear();
//     phoneController.clear();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).unfocus();
//       },
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.3),
//               blurRadius: 10,
//               offset: const Offset(0, 5),
//             ),
//           ],
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min, // Sử dụng mainAxisSize.min
//             children: [
//               _buildTextField('Enter name', nameController),
//               const SizedBox(height: 16),
//               _buildTextField('Enter date of birth', dobController),
//               const SizedBox(height: 16),
//               _buildTextField('Enter id number', idController),
//               const SizedBox(height: 16),
//               _buildTextField('Enter age', ageController),
//               const SizedBox(height: 16),
//
//               const Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text('Status:', style: TextStyle(
//                     fontFamily: 'Times New Roman',
//                     fontSize: 18,
//                   ),
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   _buildRadioOption("Thường trú"),
//                   _buildRadioOption("Tạm trú"),
//                   _buildRadioOption("Tạm vắng"),
//                 ],
//               ),
//
//               // const SizedBox(height: 12),
//               _buildTextField('Enter room', roomController),
//               const SizedBox(height: 16),
//               _buildTextField('Enter phone number', phoneController),
//               const SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () {
//                   handleOnClick();
//                   FocusScope.of(context).unfocus();
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue,
//                   foregroundColor: Colors.white,
//                   padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                 ),
//                 child: const Text(
//                   'Add',
//                   style: TextStyle(
//                     fontFamily: 'Times New Roman',
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextField(String label, TextEditingController controller) {
//     return TextField(
//       controller: controller,
//       decoration: InputDecoration(
//         labelText: label,
//         border: const OutlineInputBorder(),
//         focusedBorder: OutlineInputBorder(
//           borderSide: const BorderSide(color: Colors.blue, width: 2),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderSide: const BorderSide(color: Colors.grey, width: 1),
//           borderRadius: BorderRadius.circular(10),
//         ),
//       ),
//       style: const TextStyle(
//         fontFamily: 'Times New Roman',
//         fontWeight: FontWeight.bold,
//         fontSize: 18,
//       ),
//     );
//   }
//
//   Widget _buildRadioOption(String title) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Radio<String>(
//           value: title,
//           groupValue: _selectedStatus,
//           onChanged: (String? value) {
//             setState(() {
//               _selectedStatus = value; // Cập nhật lựa chọn
//             });
//           },
//         ),
//         Text(title, style: const TextStyle(fontSize: 17),),
//       ],
//     );
//   }
// }




import 'package:flutter/material.dart';
import '../../../../../common/date_filter.dart';
import '../../../../../models/resident_info.dart';

class AddFooter extends StatefulWidget {
  const AddFooter({super.key, required this.addNewResident});

  final Function addNewResident;

  @override
  State<AddFooter> createState() => _AddFooterState();
}

class _AddFooterState extends State<AddFooter> {
  String? _selectedStatus;
  String _dob = '';

  final TextEditingController nameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController roomController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  void handleOnClick() {
    final name = nameController.text.trim();
    final dob = dobController.text.trim();
    var id = idController.text.trim();
    final age = int.tryParse(ageController.text.trim()) ?? 0;
    final status = _selectedStatus;
    final room = int.tryParse(roomController.text.trim()) ?? 0;
    final phone = phoneController.text.trim();

    if (id.isEmpty) {
      id = DateTime.now().toString();
    }

    final resident = ResidentInfo(
      full_name: name,
      date_of_birth: dob,
      id_number: id,
      age: age,
      room: room,
      phone_number: phone,
      status: status,
    );

    widget.addNewResident(resident);

    nameController.clear();
    dobController.clear();
    idController.clear();
    ageController.clear();
    roomController.clear();
    phoneController.clear();
  }

  void showDateFilterPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: DateFilterPopup(
          onDateSelected: (String selectedDate) {
            setState(() {
              dobController.text = selectedDate; // Cập nhật ngày sinh vào TextField
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField('Enter name', nameController),
              const SizedBox(height: 16),
              _buildTextField('Enter date of birth', dobController, onTap: () {
                showDateFilterPopup(context);
              }),
              const SizedBox(height: 16),
              _buildTextField('Enter id number', idController),
              const SizedBox(height: 16),
              _buildTextField('Enter age', ageController),
              const SizedBox(height: 16),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Status:', style: TextStyle(
                  fontFamily: 'Times New Roman',
                  fontSize: 18,
                )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildRadioOption("Thường trú"),
                  _buildRadioOption("Tạm trú"),
                  _buildRadioOption("Tạm vắng"),
                ],
              ),
              _buildTextField('Enter room', roomController),
              const SizedBox(height: 16),
              _buildTextField('Enter phone number', phoneController),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  handleOnClick();
                  FocusScope.of(context).unfocus();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Add',
                  style: TextStyle(
                    fontFamily: 'Times New Roman',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap, // Gọi hàm onTap nếu được cung cấp
      child: AbsorbPointer( // Ngăn không cho nhập văn bản nếu không cần thiết
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          style: const TextStyle(
            fontFamily: 'Times New Roman',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Widget _buildRadioOption(String title) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          value: title,
          groupValue: _selectedStatus,
          onChanged: (String? value) {
            setState(() {
              _selectedStatus = value; // Cập nhật lựa chọn
            });
          },
        ),
        Text(title, style: const TextStyle(fontSize: 17)),
      ],
    );
  }
}
