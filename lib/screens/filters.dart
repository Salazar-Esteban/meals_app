import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/provider/filters.provider.dart';
import 'package:meals_app/screens/tabs.dart';

enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class FiltersScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = useProvider(ref, filtersProvider);
    final handleFilter = ref.read(filtersProvider.notifier).setFilter;
    return Scaffold(
        appBar: AppBar(
          title: Text('Your filters'),
        ),
        body: Column(
          children: [
            SwitchListTile(
                title: Text('Gluten free'),
                subtitle: const Text('Only include gluten-free meals'),
                value: filters[Filter.glutenFree],
                onChanged: (val) =>
                    handleFilter(filter: Filter.glutenFree, val: val)),
            SwitchListTile(
                title: Text('Vegetarian'),
                subtitle: const Text('Only include vegetarian meals'),
                value: filters[Filter.vegetarian],
                onChanged: (val) =>
                    handleFilter(filter: Filter.vegetarian, val: val)),
            SwitchListTile(
                title: Text('Vegan'),
                subtitle: const Text('Only include vegan meals'),
                value: filters[Filter.vegan],
                onChanged: (val) =>
                    handleFilter(filter: Filter.vegan, val: val)),
            SwitchListTile(
                title: Text('Lactose'),
                subtitle: const Text('Only include des-lactose meals'),
                value: filters[Filter.lactoseFree],
                onChanged: (val) =>
                    handleFilter(filter: Filter.lactoseFree, val: val))
          ],
        ) // same code as shown in the next lecture

        );
  }
}
