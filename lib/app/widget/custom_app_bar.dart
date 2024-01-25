import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final IconData leadingIcon;
  final String title;
  final bool back;

  const CustomAppBar({
    Key? key,
    required this.leadingIcon,
    required this.title,
    required this.back
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: back,

      leading: IconButton(
        icon: Icon(leadingIcon),
        onPressed: () {
          // Add your leading icon action here
        },
      ),
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24.0,
          // You can adjust the style of the title text here
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
