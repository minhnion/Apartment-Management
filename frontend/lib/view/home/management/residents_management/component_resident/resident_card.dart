import 'package:flutter/material.dart';
import '../../../../../common/show_dialog.dart';
import '../../../../../models/resident_info.dart';
import 'edit_footer.dart';
class ResidentCard extends StatefulWidget {
  final ResidentInfo item;
  final Function(int) onDelete;
  final Function(int, String, String, String, String,String) onEdit;

  const ResidentCard({super.key, required this.item, required this.onDelete, required this.onEdit});

  @override
  State<ResidentCard> createState() => _ResidentCardState();
}

class _ResidentCardState extends State<ResidentCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context){
              return AlertDialog(
                title: const Center(
                  child: Text(
                    'Thông tin',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow('Tên:', widget.item.full_name ?? 'Chưa được cung cấp'),
                      _buildInfoRow('ID cư dân:', widget.item.res_id != null ? widget.item.res_id.toString() : 'Chưa được cung cấp'),
                      _buildInfoRow('ID người dùng:', widget.item.user_id != null ? widget.item.user_id.toString() : 'Chưa được cung cấp'),
                      _buildInfoRow('Ngày sinh:', widget.item.date_of_birth ?? 'Chưa được cung cấp'),
                      _buildInfoRow('Số ID:', widget.item.id_number ?? 'Chưa được cung cấp'),
                      _buildInfoRow('Tuổi:', widget.item.age != null ? widget.item.age.toString() : 'Chưa được cung cấp'),
                      _buildInfoRow('Tình trạng:', widget.item.status ?? 'Chưa được cung cấp'),
                      _buildInfoRow('Phòng:', widget.item.room != null ? widget.item.room.toString() : 'Chưa được cung cấp'),
                      _buildInfoRow('Số điện thoại:', widget.item.phone_number ?? 'Chưa được cung cấp'),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue, // Nền nút
                      foregroundColor: Colors.white, // Màu chữ
                    ),
                    child: const Center(
                      child: Text("OK", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            }
        );
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.person_pin_outlined, color: Colors.blue[500]!, size: 45,),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            widget.item.full_name!,
                            style: const TextStyle(fontSize: 24, color: Colors.black87, fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
              
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return EditFooter(
                                  id: widget.item.res_id!,
                                  editResidentInfo: (id, newName, newDob, newStatus, newPhoneNumber,newHousehold) {
                                    widget.onEdit(id, newName, newDob, newStatus, newPhoneNumber,newHousehold);
                                  },
                                );
                              }
                          );
                        },
                        child: const Icon(
                          Icons.edit,
                          size: 30,
                          color: Color.fromRGBO(0, 0, 0, 0.6),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          showdeleteform(context, 'Cảnh báo', 'Bạn có chắc chắn muốn xóa cư dân này không?');
                        },
                        child: const Icon (
                          Icons.delete,
                          size: 30,
                          color: Color.fromRGBO(0, 0, 0, 0.6),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.home_outlined, color: Colors.grey[600]!, size: 25,), // Biểu tượng 2
                          const SizedBox(width: 10),
                          Text(
                            widget.item.room.toString(),
                            style: const TextStyle(fontSize: 17, color: Colors.black87),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.call_outlined, color: Colors.grey[600]!, size: 25),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              widget.item.phone_number ?? 'Chưa được cung cấp',
                              style: const TextStyle(fontSize: 17, color: Colors.black87),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0), // Tăng khoảng cách giữa các hàng
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2, // Tăng kích thước cho nhãn
            child: Text(
              label,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
          ),
          Expanded(
            flex: 3, // Tăng kích thước cho giá trị
            child: Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  void showdeleteform(BuildContext context,String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),),
          content: Text(message, style: const TextStyle(fontSize: 18),),
          contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  child: const Center(
                    child: Text("OK", style: TextStyle(fontSize: 18),),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // Đóng hộp thoại
                    if (widget.item.res_id != null) {
                      widget.onDelete( widget.item.res_id!);
                    } else {
                      Navigator.of(context).pop();
                      showinform(context, 'Lỗi', 'Thiếu ID cư dân.');
                    }
                  },
                ),
                TextButton(
                  child: const Center(
                    child: Text("Hủy bỏ", style: TextStyle(fontSize: 18,color: Colors.red),),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}




