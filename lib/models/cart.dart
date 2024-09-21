import 'package:nextmeal/models/meal.dart';
import 'package:flutter/material.dart';

class Cart extends Meal {
  Cart(
      {required this.quantity,
      id,
      categories,
      title,
      imageUrl,
      ingredients,
      steps,
      duration,
      complexity,
      affordability,
      isGlutenFree,
      isLactoseFree,
      isVegan,
      isVegetarian})
      : super(
          id: id,
          categories: categories,
          title: title,
          imageUrl: imageUrl,
          ingredients: ingredients,
          steps: steps,
          duration: duration,
          complexity: complexity,
          affordability: affordability,
          isGlutenFree: isGlutenFree,
          isLactoseFree: isLactoseFree,
          isVegan: isVegan,
          isVegetarian: isVegetarian,
        );
  int quantity = 0;
}
