import 'package:flutter/material.dart';
import 'package:msig_food/src/src.dart';

class MealItemCard extends StatelessWidget {
  final int index;
  final Meal meal;
  final Function()? onDelete;

  const MealItemCard({
    super.key,
    required this.index,
    required this.meal,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        key: Key(UIKeys.mealItem(index)),
        onTap: () => Navigator.pushNamed(
          context,
          RouteName.detailScreen,
          arguments: ScreenArgument(data: meal),
        ),
        child: Stack(
          children: [
            Container(
              key: Key(
                meal.thumbnail != null
                    ? UIKeys.mealItemThumbnailLoaded(index)
                    : UIKeys.mealItemThumbnailNull(index),
              ),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(10),
                image: meal.thumbnail != null
                    ? DecorationImage(
                        image: NetworkImage(meal.thumbnail!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  meal.name ?? '-',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            if (onDelete != null) ...[
              Positioned(
                right: 20,
                bottom: 20,
                child: IconButton(
                  onPressed: onDelete,
                  color: Colors.white,
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ],
        ),
      );
}
