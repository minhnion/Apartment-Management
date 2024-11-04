import 'package:flutter/material.dart';
import 'package:frontend/view/home/management/component_management/management_card.dart';

class User extends StatelessWidget {
  const User({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return const SingleChildScrollView(
  child: Padding(
  padding: EdgeInsets.all(20.0),
  child: Column(
  children: [
  ManagementCard(imagelink: 'frontend/assets/images/update.jpg', title: 'Update',),
  SizedBox(height: 20,),
  ManagementCard(imagelink: 'frontend/assets/images/pay.jpg', title: 'Payment',),
  ],
  ),
  ),
  );

  }
  }