import 'package:bro/blocs/preferred_language/preferred_language_bucket.dart';
import 'package:bro/blocs/settings/settings_bucket.dart';
import 'package:bro/blocs/settings/settings_state.dart';

import 'package:bro/models/languages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  late PreferredLanguageBloc _preferredLanguageBloc;
  String dropdownValue = 'NO';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _settingsBloc = BlocProvider.of<SettingsBloc>(context);
    _settingsBloc.add(LanguagesRequested());
    _preferredLanguageBloc = BlocProvider.of<PreferredLanguageBloc>(context);
    //_preferredLanguageBloc.add(PreferredLanguageRequested());
    /*_getPreferredLanguage().then((value) {
      setState(() {
        dropdownValue = value;
      });
    });
        */
    //_getPreferredLanguage();
  }

  void _changeLanguage(String lang) {
    _preferredLanguageBloc
        .add(MutatePreferredLanguage(preferredLanguage: lang));
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
          var languages = state.languages.languages;
          return Scaffold(
              appBar: _buildAppBar(),
              body: BlocBuilder<PreferredLanguageBloc, PreferredLanguageState>(
                  builder: (context, state) {
                if (state is LanguageChanged) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            'Språk',
                            style: Theme.of(context).textTheme.headline6,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Card(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: DropdownButton<String>(
                              value: state.newLang,
                              icon: const FaIcon(FontAwesomeIcons.chevronDown),
                              iconSize: 16,
                              isExpanded: true,
                              underline: Container(),
                              style: Theme.of(context).textTheme.subtitle1,
                              onChanged: (String? newValue) {
                                _changeLanguage(newValue!);
                              },
                              items: languages.map<DropdownMenuItem<String>>(
                                  (Language lang) {
                                return DropdownMenuItem<String>(
                                  value: lang.slug,
                                  child: Text(lang.languageFullName),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              }));
        }
        return Scaffold(
          appBar: _buildAppBar(),
          body: Center(child: Text('Dunno')),
        );
      },
    );
  }
}
