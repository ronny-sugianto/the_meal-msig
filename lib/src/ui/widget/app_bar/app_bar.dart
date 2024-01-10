import 'package:flutter/material.dart';
import 'package:msig_food/src/src.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool? isBackButton;
  final Widget? actionWidget;

  const DefaultAppBar({
    super.key,
    this.title,
    this.isBackButton = true,
    this.actionWidget,
  });

  @override
  Widget build(BuildContext context) => AppBar(
        leading: isBackButton == true
            ? IconButton(
                key: const Key(UIKeys.appBarBack),
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              )
            : null,
        title: title != null
            ? Text(
                title!,
                key: const Key(UIKeys.appBarTitle),
              )
            : null,
        actions: actionWidget != null ? [actionWidget!] : null,
        centerTitle: true,
        backgroundColor: Colors.white,
      );

  @override
  Size get preferredSize => const Size(double.infinity, 40);
}
