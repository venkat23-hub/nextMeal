import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nextmeal/data/dummy_data.dart';
import 'package:nextmeal/models/meal.dart';

class FavouriteMealsNotifier extends StateNotifier <List<Meal>> {
  FavouriteMealsNotifier() : super([]);
  bool toggleMealFavouriteStatus(Meal meal){
    final maelIsFavourite = state.contains(meal);

    if(maelIsFavourite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    }else{
      state = [...state, meal];
      return true;
    }


    state = [];
  }
}
  final favouritesMealsProvider = StateNotifierProvider <FavouriteMealsNotifier,List<Meal>>(
      (ref) {
        return FavouriteMealsNotifier();
      }
  );
