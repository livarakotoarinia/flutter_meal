import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersPage extends StatefulWidget {
  static const routeName = "/filters";

  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FiltersPage(this.saveFilters, this.currentFilters);

  @override
  _FiltersPageState createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  initState() {
    _glutenFree = widget.currentFilters['gluten'] as bool;
    _lactoseFree = widget.currentFilters['lactose'] as bool;
    _vegetarian = widget.currentFilters['vegetarian'] as bool;
    _vegan = widget.currentFilters['vegan'] as bool;
    super.initState();
  }

  Widget _buildSwitchListTile(
    String title,
    String subTitle,
    bool currentValue,
    Function(bool) updateValue,
  ) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subTitle),
      value: currentValue,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filters"),
        actions: [
          IconButton(
              onPressed: () {
                final selectedFilter = {
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegetarian': _vegetarian,
                  'vegan': _vegan,
                };
                widget.saveFilters(selectedFilter);
              },
              icon: Icon(Icons.save)),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Adjust your meal selection.",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              _buildSwitchListTile(
                'Gluten Free',
                'Only include gluten free meals',
                _glutenFree,
                (newValue) => setState(() => _glutenFree = newValue),
              ),
              _buildSwitchListTile(
                'Lactose Free',
                'Only include lactose free meals',
                _lactoseFree,
                (newValue) => setState(() => _lactoseFree = newValue),
              ),
              _buildSwitchListTile(
                'Vegetarian food',
                'Only include Vegetarian meals',
                _vegetarian,
                (newValue) => setState(() => _vegetarian = newValue),
              ),
              _buildSwitchListTile(
                'Vegan',
                'Only include vegan meals',
                _vegan,
                (newValue) => setState(() => _vegan = newValue),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
