library country_state_city_picker_nona;

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../utilities/status_model.dart' as status_model;

class SelectCountryState extends StatefulWidget {
  final ValueChanged<String> onCountryChanged;
  final ValueChanged<String> onStateChanged;
  //final ValueChanged<String> onCityChanged;
  final TextStyle? style;
  final Color? dropdownColor;
  final String selectedCountry;
  final String selectedState;

  const SelectCountryState(
      {Key? key,
        required this.onCountryChanged,
        required this.onStateChanged,
        required this.selectedCountry,
        required this.selectedState,
        //required this.onCityChanged,
        this.style,
        this.dropdownColor})
      : super(key: key);

  @override
  _SelectCountryStateState createState() => _SelectCountryStateState();
}

class _SelectCountryStateState extends State<SelectCountryState> {
  final List<String> _country = [];
  String _selectedCountry = "";
  String _selectedState = "";
  final List<String> _states = [];
  var responses;

  @override
  void initState() {
    _selectedCountry = widget.selectedCountry;
    _selectedState = widget.selectedState;
    getCounty();
    _states.clear();
    _country.clear();
    getState();
    super.initState();
  }

  Future getResponse() async {
    var res = await rootBundle.loadString('packages/country_state_city_picker/lib/assets/country.json');
    return jsonDecode(res);
  }

  Future getCounty() async {
    _country.clear();

    var countryRes = await getResponse() as List;
    for (var data in countryRes) {
      var model = status_model.StatusModel();
      model.name = data['name'];
      model.emoji = data['emoji'];
      if (!mounted) return;
      setState(() {
        _country.add(/*model.emoji! + "    " +*/ model.name!);
      });
    }

    return _country;
  }

  Future getState() async {
    _states.clear();
    //_states = ["Select State"];

    var response = await getResponse();
    var takestate = response
        .map((map) => status_model.StatusModel.fromJson(map))
        .where((item) => /*item.emoji + "    " +*/ item.name == _selectedCountry)
        .map((item) => item.state)
        .toList();
    var states = takestate as List;
    for (var f in states) {
      if (!mounted) return;
      setState(() {
        var name = f.map((item) => item.name).toList();
        for (var stateName in name) {
          if (kDebugMode) {
            print(stateName.toString());
          }
          _states.add(stateName.toString());
        }
      });
    }

    return _states;
  }

  /*Future getCity() async {
    var response = await getResponse();
    var takestate = response
        .map((map) => StatusModel.StatusModel.fromJson(map))
        .where((item) => item.emoji + "    " + item.name == _selectedCountry)
        .map((item) => item.state)
        .toList();
    var states = takestate as List;
    states.forEach((f) {
      var name = f.where((item) => item.name == _selectedState);
      var cityname = name.map((item) => item.city).toList();
      cityname.forEach((ci) {
        if (!mounted) return;
        setState(() {
          var citiesname = ci.map((item) => item.name).toList();
          for (var citynames in citiesname) {
            print(citynames.toString());

            _cities.add(citynames.toString());
          }
        });
      });
    });
    return _cities;
  }*/

  void _onSelectedCountry(String value) {
    if (!mounted) return;
    setState(() {
      //_selectedState = "Choose State";
      //_states = ["Select State"];
      _selectedState = "";
      _selectedCountry = value;
      widget.onCountryChanged(value);
      getState();
    });
  }

  void _onSelectedState(String value) {
    if (!mounted) return;
    setState(() {
      //_selectedCity = "Choose City";
      _selectedState = value;
      widget.onStateChanged(value);
      //getCity();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _selectedCountry == ""
            ? DropdownButtonFormField<String>(
                dropdownColor: widget.dropdownColor,
                isExpanded: true,
                items: _country.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Row(
                      children: [
                        Text(
                          dropDownStringItem,
                          style: widget.style,
                        )
                      ],
                    ),
                  );
                }).toList(),
                validator: (String? value) {
                  return (value?.isEmpty ?? true)
                      ? "Please select country"
                      : null;
                },
                decoration: const InputDecoration(
                  hintText: "Country",
                  labelText: "Country",
                  fillColor: Colors.transparent,
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.only(
                      left: 15, bottom: -3, top: -3, right: 15),
                ),
                onChanged: (value) => _onSelectedCountry(value!),
                //value: _selectedCountry,
              )
            : DropdownButtonFormField<String>(
                dropdownColor: widget.dropdownColor,
                isExpanded: true,
                items: _country.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Row(
                      children: [
                        Text(
                          dropDownStringItem,
                          style: widget.style,
                        )
                      ],
                    ),
                  );
                }).toList(),
                validator: (String? value) {
                  return (value?.isEmpty ?? true)
                      ? "Please select country"
                      : null;
                },
                decoration: const InputDecoration(
                  hintText: "Country",
                  labelText: "Country",
                  fillColor: Colors.transparent,
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.only(
                      left: 15, bottom: -3, top: -3, right: 15),
                ),
                onChanged: (value) => _onSelectedCountry(value!),
                value: _selectedCountry,
        ),
        const SizedBox(height: 20.0),
        _selectedState == ""
            ? DropdownButtonFormField<String>(
          dropdownColor: widget.dropdownColor,
          isExpanded: true,
          items: _states.map((String dropDownStringItem) {
            return DropdownMenuItem<String>(
              value: dropDownStringItem,
              child: Text(dropDownStringItem, style: widget.style),
            );
          }).toList(),
          validator: (String? value) {
            return (value?.isEmpty ?? true)
                ? "Please select state"
                : null;
          },
          decoration: const InputDecoration(
            hintText: "State/Province",
            labelText: "State/Province",
            border: OutlineInputBorder(),
            fillColor: Colors.transparent,
            contentPadding: EdgeInsets.only(
                left: 15, bottom: -3, top: -3, right: 15),
          ),
          onChanged: (value) => _onSelectedState(value!),
          //value: _selectedState,
        )
            : DropdownButtonFormField<String>(
                dropdownColor: widget.dropdownColor,
                isExpanded: true,
                items: _states.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem, style: widget.style),
                  );
                }).toList(),
                validator: (String? value) {
                  return (value?.isEmpty ?? true)
                      ? "Please select state"
                      : null;
                },
                decoration: const InputDecoration(
                  hintText: "State/Province",
                  labelText: "State/Province",
                  fillColor: Colors.transparent,
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.only(
                      left: 15, bottom: -3, top: -3, right: 15),
                ),
                onChanged: (value) => _onSelectedState(value!),
                value: (_states.contains(_selectedState)) ? _selectedState : "",
        ),
        /*DropdownButton<String>(
          dropdownColor: widget.dropdownColor,
          isExpanded: true,
          items: _cities.map((String dropDownStringItem) {
            return DropdownMenuItem<String>(
              value: dropDownStringItem,
              child: Text(dropDownStringItem, style: widget.style),
            );
          }).toList(),
          onChanged: (value) => _onSelectedCity(value!),
          value: _selectedCity,
        ),*/
        /*const SizedBox(
          height: 10.0,
        ),*/
      ],
    );
  }
}
