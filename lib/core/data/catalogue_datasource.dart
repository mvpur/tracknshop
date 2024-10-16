import 'package:flutter/material.dart';
import 'package:track_shop_app/entities/catalogue.dart';

final catalogueList = [
  Catalogue(
      id: '1',
      icon: const Icon(Icons.kitchen),
      name: 'Lista de compras',
      date: DateTime(2023, 1, 15)),
  Catalogue(
      id: '2',
      icon: const Icon(Icons.star),
      name: 'Wishlist',
      date: DateTime(2022, 5, 20)),
  Catalogue(
      id: '3',
      icon: const Icon(Icons.book),
      name: 'Libros',
      date: DateTime(2021, 11, 3)),
];
