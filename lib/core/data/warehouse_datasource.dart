import 'package:flutter/material.dart';
import 'package:track_shop_app/entities/warehouse.dart';

final warehouseList = [
  Warehouse(id: '1', icon: const Icon(Icons.kitchen), name: 'Alacena',      date: DateTime(2023, 1, 15)),
  Warehouse(id: '2', icon: const Icon(Icons.bathtub), name: 'Baño', 
      date: DateTime(2022, 7, 27)),
  Warehouse(id: '3', icon: const Icon(Icons.book), name: 'Biblioteca',
      date: DateTime(2022, 3, 18)),
  Warehouse(id: '4', icon: const Icon(Icons.fastfood), name: 'Despensa',
      date: DateTime(2022, 2, 12)),
];
