import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Playlist App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _playingSong = -1;
  final List<Song> _playList = [];

  @override
  void initState() {
    // fill the playlist with mock data
    for (var i = 0; i < 20; i++) {
      _playList.add(Song('Song $i title','Artist $i name'));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Playlist App'),
        ),
        body: ListView.separated(
          padding: const EdgeInsets.only(top: 16.0),
          itemCount: _playList.length,
          separatorBuilder: (BuildContext context, int index) {
            return const Divider();
          },
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(_playList[index].title),
              subtitle: Text(_playList[index].artist),
              leading: CircleAvatar(
                backgroundImage: AssetImage(_playList[index].cover),
              ),
              trailing: Icon(
                _playingSong == index ? Icons.pause : Icons.play_arrow,
              ),
              onTap: () => _updatePlayingSong(index),
            );
          },
        ),
      ),
    );
  }

  void _updatePlayingSong(int index) => setState(() {
        if (_playingSong == index) {
          _playingSong = -1;
          showSnackBar('Song $index title paused');
        } else {
          _playingSong = index;
          showSnackBar('Playing Song $index title');
        }
      });

  void showSnackBar(String s) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s)));
}

class Song {
  String title;
  String artist;
  String cover = 'assets/img/album_cover.jpg';

  Song(this.title, this.artist);
}