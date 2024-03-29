import 'package:flutter/material.dart';
import 'package:msig_food/src/src.dart';

class DefaultLoading extends StatelessWidget {
  const DefaultLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
        child: CircularProgressIndicator(
          key: key ?? const Key(UIKeys.singleLoading),
        ),
      );
}
