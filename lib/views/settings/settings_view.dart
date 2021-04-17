import 'package:bro/blocs/settings/settings_bucket.dart';
import 'package:bro/data/settings_repository.dart';
import 'package:bro/models/languages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

AppBar _buildAppBar() {
  return AppBar(
    title: Text('Innstillinger'),
  );
}

class _SettingsViewState extends State<SettingsView> {
  late SettingsBloc _settingsBloc;
  String selectedLang = '';
  String dropdownValue = 'NO';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _settingsBloc = BlocProvider.of<SettingsBloc>(context);
    _settingsBloc.add(LanguagesRequested());

    _getPreferredLanguage().then((value) {
      setState((){
        dropdownValue = value;
        debugPrint(value);
      });
    });
    //_getPreferredLanguage();
  }

  void _changeLanguage(String lang) {
    SharedPreferences.getInstance()
        .then((prefs) => prefs.setString('lang', lang));
  }

  Future<String> _getPreferredLanguage(){
    //SharedPreferences.getInstance().then((prefs) => prefs.clear());
    return SharedPreferences.getInstance().then((prefs) => prefs.getString('lang')??'NO');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        if (state is Loading) {
          return Scaffold(
            appBar: _buildAppBar(),
            body: LinearProgressIndicator(),
          );
        }

        if (state is Failed) {
          return Scaffold(
            appBar: _buildAppBar(),
            body: Center(child: Text('Det har skjedd en feil')),
          );
        }

        if (state is Success) {
          return Scaffold(
              appBar: _buildAppBar(),
              body: Column(
                children: [
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValue) {
                      _changeLanguage(newValue!);
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: state.languages.languages
                        .map<DropdownMenuItem<String>>((Language lang) {
                      return DropdownMenuItem<String>(
                        value: lang.slug,
                        child: Text(lang.languageFullName),
                      );
                    }).toList(),
                  ),
                ],
              ));
        }
        return Scaffold(
          appBar: _buildAppBar(),
          body: Center(child: Text('Dunno')),
        );
      },
    );
  }
}
