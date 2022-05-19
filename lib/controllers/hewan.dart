import 'package:flutter/material.dart';
import '../layout/app_layout.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import '../config.dart';
import '../models/modelhewan.dart';
import '/config.dart';
import 'barcode_scanner_without_controller.dart';
import 'hewandetail.dart';

class HewanPage extends StatefulWidget {
  static const route = "/hewan";

  @override
  _HewanPageState createState() => _HewanPageState();
}

class _HewanPageState extends State<HewanPage> {
  bool isInit = true;
  bool isLoading = false;
  String? token;
  static const historyLength = 5;

  List<String> _searchHistory = [];

  List<String>? filteredSearchHistory;

  String? selectedTerm;

  List<String> filterSearchTerms({
    @required String? filter,
  }) {
    if (filter != null && filter.isNotEmpty) {
      return _searchHistory.reversed
          .where((term) => term.startsWith(filter))
          .toList();
    } else {
      return _searchHistory.reversed.toList();
    }
  }

  void addSearchTerm(String term) {
    if (_searchHistory.contains(term)) {
      putSearchTermFirst(term);
      return;
    }
    _searchHistory.add(term);
    if (_searchHistory.length > historyLength) {
      _searchHistory.removeRange(0, _searchHistory.length - historyLength);
    }
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  void deleteSearchTerm(String term) {
    _searchHistory.removeWhere((t) => t == term);
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  void putSearchTermFirst(String term) {
    deleteSearchTerm(term);
    addSearchTerm(term);
  }

  void _openScanPage(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const BarcodeScannerWithoutController()),
    );
    setState(() {
      addSearchTerm(result);
      selectedTerm = result;
    });
    controller.close();
  }

  late FloatingSearchBarController controller;
  @override
  void initState() {
    super.initState();
    controller = FloatingSearchBarController();
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: AppLayout(
        content: Container(
          child: FloatingSearchBar(
            controller: controller,
            body: FloatingSearchBarScrollNotifier(
              child: SearchResultsListView(
                searchTerm: selectedTerm.toString(),
              ),
            ),
            transition: CircularFloatingSearchBarTransition(),
            physics: BouncingScrollPhysics(),
            title: Text(
              selectedTerm ?? 'Search Hewan',
              style: Theme.of(context).textTheme.headline6,
            ),
            hint: 'Cari berdasarkan ID, ID Hewan, atau muqorib',
            actions: [
              FloatingSearchBarAction(
                showIfOpened: false,
                child: CircularButton(
                  icon: const Icon(Icons.camera_alt),
                  onPressed: () {
                    _openScanPage(context);
                  },
                ),
              ),
              FloatingSearchBarAction(
                showIfOpened: false,
                child: CircularButton(
                  icon: const Icon(Icons.cleaning_services),
                  onPressed: () {
                    setState(() {
                      addSearchTerm(controller.query);
                      selectedTerm = controller.query;
                    });
                    controller.close();
                  },
                ),
              ),
              FloatingSearchBarAction.searchToClear(),
            ],
            onQueryChanged: (query) {
              setState(() {
                filteredSearchHistory = filterSearchTerms(filter: query);
              });
            },
            onSubmitted: (query) {
              setState(() {
                addSearchTerm(query);
                selectedTerm = query;
              });
              controller.close();
            },
            builder: (context, transition) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Material(
                  color: Colors.white,
                  elevation: 4,
                  child: Builder(
                    builder: (context) {
                      if (filteredSearchHistory!.isEmpty &&
                          controller.query.isEmpty) {
                        return Container(
                          height: 56,
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Text(
                            'Start searching',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        );
                      } else if (filteredSearchHistory!.isEmpty) {
                        return ListTile(
                          title: Text(controller.query),
                          leading: const Icon(Icons.search),
                          onTap: () {
                            setState(() {
                              addSearchTerm(controller.query);
                              selectedTerm = controller.query;
                            });
                            controller.close();
                          },
                        );
                      } else {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: filteredSearchHistory!
                              .map(
                                (term) => ListTile(
                                  title: Text(
                                    term,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  leading: const Icon(Icons.history),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () {
                                      setState(() {
                                        deleteSearchTerm(term);
                                      });
                                    },
                                  ),
                                  onTap: () {
                                    setState(() {
                                      putSearchTermFirst(term);
                                      selectedTerm = term;
                                    });
                                    controller.close();
                                  },
                                ),
                              )
                              .toList(),
                        );
                      }
                    },
                  ),
                ),
              );
            },
          ),
        ),
      )),
    );
  }
}

class SearchResultsListView extends StatelessWidget {
  final String searchTerm;

  const SearchResultsListView({
    Key? key,
    required this.searchTerm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (searchTerm == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search,
              size: 64,
            ),
            Text(
              'Memulai Pencarian',
              style: Theme.of(context).textTheme.headline5,
            )
          ],
        ),
      );
    }

    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    Future<Modelhewan> getData() async {
      Uri url = Uri.parse(Config.getHewan + '?search=' + searchTerm);
      final SharedPreferences prefs = await _prefs;
      var token = prefs.getString('token');
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        return Modelhewan.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Failed to load");
      }
    }

    final fsb = FloatingSearchBar.of(context);
    return Container(
      padding: EdgeInsets.only(top: 70.0),
      child: FutureBuilder<Modelhewan>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body: SafeArea(
                child: ListView.builder(
                  itemCount: snapshot.data!.rows.length,
                  itemBuilder: (context, index) {
                    var item = snapshot.data!.rows[index];
                    return GestureDetector(
                      onTap: () => Navigator.of(context).push(
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new HewanDetail(
                                      id: item.id,
                                      idHewan: item.noHewanQurban,
                                      idCabang: item.kantorTransaksi,
                                      status: item.status,
                                      video: item.video,
                                      foto1: item.foto1,
                                      foto2: item.foto2,
                                      foto3: item.foto3,
                                      foto4: item.foto4,
                                      idMitra: item.idMitra,
                                      namaMuqorib: item.muqorib,
                                      updatedAt: item.dateAdd))),
                      child: Card(
                        child: ListTile(
                          leading: Icon(Icons.pages_outlined),
                          title: Text(item.noHewanQurban.toString(),
                              style:
                                  TextStyle(color: Colors.green, fontSize: 15)),
                          trailing: Text(
                            "GFG",
                            style: TextStyle(color: Colors.green, fontSize: 15),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
