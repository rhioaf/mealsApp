import 'package:flutter/material.dart';
import 'package:mealsApp/widgets/drawer.dart';

class Settings extends StatefulWidget {
  static const routeName = '/settings';

  final Function saveSettings;
  final Map<String, bool> currentSetting;

  Settings(this.currentSetting, this.saveSettings);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.currentSetting['gluten'];
    _lactoseFree = widget.currentSetting['lactose'];
    _vegetarian = widget.currentSetting['vegetarian'];
    _vegan = widget.currentSetting['vegan'];
    super.initState();
  }

  Widget _buildListSetting(String title, String subTitle, var currentValue, Function updateValue){
    return SwitchListTile(
      value: currentValue,
      onChanged: updateValue,
      title: Text(title),
      subtitle: Text(subTitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Settings'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final selectedSettings = {
                'gluten' : _glutenFree,
                'lactose' : _lactoseFree,
                'vegetarian' : _vegetarian,
                'vegan' : _vegan
              };
              widget.saveSettings(selectedSettings);
            }
          ),
        ],
      ),
      drawer: DrawerApp(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(15),
            child: Text(
              'Adjust Meal Settings',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildListSetting(
                  'Glutten Free', 
                  'Only include gluten-free meals', 
                  _glutenFree,
                  (newValue) {
                    setState(() {
                      _glutenFree = newValue;
                    });
                  }
                ),
                _buildListSetting(
                  'Lactose Free', 
                  'Only include lactose-free meals', 
                  _lactoseFree,
                  (newValue) {
                    setState(() {
                      _lactoseFree = newValue;
                    });
                  }
                ),
                _buildListSetting(
                  'Vegetarian', 
                  'Only include vegetarian meals', 
                  _vegetarian,
                  (newValue) {
                    setState(() {
                      _vegetarian = newValue;
                    });
                  }
                ),
                _buildListSetting(
                  'Vegan', 
                  'Only include vegan meals', 
                  _vegan,
                  (newValue) {
                    setState(() {
                      _vegan = newValue;
                    });
                  }
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}