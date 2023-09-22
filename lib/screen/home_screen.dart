import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:spotifier/common/appbar.dart';
import 'package:spotifier/utils/utils.dart';
import 'package:spotify/spotify.dart' as sp;
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _controller = TextEditingController();

  Directory dir = Directory("/storage/emulated/0/Download/music/");

  Map<String, String> tracks = {};

  String regex =
      r'[^\p{Alphabetic}\p{Mark}\p{Decimal_Number}\p{Connector_Punctuation}\p{Join_Control}\s]+';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          defaultAppBar(context),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    10.0,
                    10.0,
                    10.0,
                    10.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppBar(
                        backgroundColor: Colors.transparent,
                        title: TextField(
                          controller: _controller,
                          decoration: const InputDecoration(
                            fillColor: Color.fromRGBO(20, 20, 20, 1),
                            hintText: "Playlist URL here",
                          ),
                          onSubmitted: (text) async {
                            // Take the ID from the URL
                            if (text.contains("playlist/")) {
                              final playlistID =
                                  RegExp("playlist\/([a-zA-Z0-9]{22})");
                              if (playlistID.hasMatch(text)) {
                                var match = playlistID
                                    .firstMatch(text)
                                    ?.group(1)
                                    .toString();
                                text = match.toString();
                              }
                            }

                            final spotify = sp.SpotifyApi(credentials);
                            final items = await spotify.playlists
                                .getTracksByPlaylistId(text)
                                .all();

                            String title =
                                await spotify.playlists.get(text).then((value) {
                              return value.name
                                  .toString()
                                  .replaceAll(RegExp(regex, unicode: true), '');
                            });

                            if (kDebugMode) {
                              print("[DEBUG] Playlist Title: $title");
                            }

                            if (kDebugMode) {
                              print("[DEBUG] Directory created: ${dir.path}");
                            }

                            for (var track in items) {
                              var artist = track.artists!.first.name
                                  .toString()
                                  .replaceAll(RegExp(regex, unicode: true), '');
                              var song = track.name
                                  .toString()
                                  .replaceAll(RegExp(regex, unicode: true), '');

                              var coverURL = track.album?.images?.first.url;
                              setState(() {
                                tracks.addAll(
                                    {'$artist - $song': coverURL.toString()});
                                if (kDebugMode) {
                                  print(
                                      '[DEBUG] Added $artist - $song to tracks list');
                                }
                              });
                            }
                          },
                        ),
                        actions: [
                          IconButton(
                            splashRadius: 24,
                            onPressed: () {
                              setState(() {
                                tracks.clear();
                                _controller.clear();
                              });
                            },
                            icon: const Icon(Icons.clear_rounded),
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                            ),
                            onPressed: () async {
                              print('hello');
                            },
                            icon: const Icon(Icons.downloading_rounded),
                            label: const Text(
                              'Download All',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                tracks.isNotEmpty
                    ? ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: tracks.length,
                        itemBuilder: (BuildContext context, int index) {
                          double boxSize = MediaQuery.of(context).size.height >
                                  MediaQuery.of(context).size.width
                              ? MediaQuery.of(context).size.width / 2
                              : MediaQuery.of(context).size.height / 2.5;
                          return InkWell(
                            onTap: () async {
                              if (kDebugMode) {
                                print(
                                    '[DEBUG] Clicked: ${tracks.keys.elementAt(index)}');
                              }
                            },
                            child: SizedBox(
                              height: boxSize - 100,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 70,
                                    width: 70,
                                    child: Image.network(
                                      tracks.values.elementAt(index),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      title: Text(
                                        tracks.keys.elementAt(index),
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 17),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 3.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        IconButton(
                                          splashRadius: 24,
                                          onPressed: () async {
                                            if (kDebugMode) {
                                              print(
                                                  '[DEBUG] Clicked: ${tracks[index]}');
                                            }
                                          },
                                          icon: const Icon(
                                            Icons.file_download_outlined,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    // pending search page
                    : pendingSearchPage(context)
              ],
            ),
          )
        ],
      ),
    );
  }
}

pendingSearchPage(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/svg/search.svg", height: 200, width: 100),
          const SizedBox(height: 20),
          Icon(
            Icons.download_outlined,
            color: Theme.of(context).colorScheme.secondary,
            size: 50,
          ),
          Text(
            "Paste URL to fetch songs",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    ),
  );
}
