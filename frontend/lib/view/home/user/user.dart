import 'package:flutter/material.dart';
import 'package:frontend/view/home/user/user_component/user_component_card.dart';

class User extends StatelessWidget {
  const User({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            UserComponentCard(
              imagelink: 'assets/images/update_information.jpg',
              title: 'Cập nhật thông tin',
            ),
            SizedBox(
              height: 20,
            ),
            UserComponentCard(
              imagelink: 'assets/images/payment.jpg',
              title: 'Thanh toán hóa đơn',
            ),
          ],
        ),
      ),
    );
  }
}
