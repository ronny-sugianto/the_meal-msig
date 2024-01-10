import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msig_food/src/src.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key(UIKeys.favoriteScreen),
      appBar: const DefaultAppBar(title: 'Favorite'),
      body: BlocListener<FavoriteActionCubit, BaseState>(
        listener: (context, actionState) {
          if (actionState is SuccessState) {
            context.read<FavoriteDataCubit>().initialize();
          }
        },
        child: BlocBuilder<FavoriteDataCubit, BaseState<List<FavoriteData>>>(
          bloc: context.read<FavoriteDataCubit>()..initialize(),
          builder: (context, state) {
            if (state is LoadedState) {
              return GridView.builder(
                key: const Key(UIKeys.mealList),
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                padding: const EdgeInsets.all(20),
                itemCount: state.data!.length,
                itemBuilder: (context, index) => MealItemCard(
                  index: index,
                  meal: favoriteToMeal(state.data![index]),
                  onDelete: () => context
                      .read<FavoriteActionCubit>()
                      .removeFavoriteById(state.data![index].id),
                ),
              );
            }

            if (state is EmptyState) {
              return const Center(child: Text('No Data'));
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
