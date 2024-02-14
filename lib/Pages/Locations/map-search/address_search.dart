// ignore_for_file: omit_local_variable_types

import 'package:flutter/material.dart';
import 'package:takeh_customer/Shared/i18n.dart';
import 'place_service.dart';

class AddressSearch extends SearchDelegate<Suggestion> {
  AddressSearch(this.sessionToken) {
    apiClient = PlaceApiProvider(sessionToken);
  }

  late var sessionToken;
  late PlaceApiProvider apiClient;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, Suggestion('', ''));
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<Suggestion>>(
      future: query.length < 3
          ? null
          : apiClient.fetchSuggestions(
              query, Localizations.localeOf(context).languageCode),
      builder: (context, snapshot) => query.length < 3
          ? ListTile(
              title: Text(S.current.searchForAddress),
            )
          : snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Suggestion suggestion = snapshot.data![index];
                    return ListTile(
                      title: Text(suggestion.description),
                      onTap: () {
                        close(context, suggestion);
                      },
                    );
                  })
              : ListTile(
                  title: Text('${S.current.loading} ...'),
                ),
    );
  }
}
