import 'package:flutter/material.dart';
import 'package:uts_cinemate/models/player.dart';
import 'package:uts_cinemate/screens/detail_screen_player.dart';
import 'package:uts_cinemate/services/api_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final ApiService _apiService = ApiService();
  List<Player> _players = [];
  bool _isLoading = false;

  void _searchPlayers() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final result = await _apiService.searchPlayers(_controller.text);
      setState(() {
        _players = result.map((e) => Player.fromJson(e)).toList();
      });
    } catch (e) {
      setState(() {
        _players = [];
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Players"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: "Search for a player",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _searchPlayers,
                ),
              ),
              onSubmitted: (_) => _searchPlayers(),
            ),
            const SizedBox(height: 16),
            if (_isLoading) const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Expanded(
              child: _players.isEmpty
                  ? const Center(child: Text('No players found'))
                  : ListView.builder(
                      itemCount: _players.length,
                      itemBuilder: (context, index) {
                        final player = _players[index];
                        return ListTile(
                          leading: player.thumb != null &&
                                  player.thumb!.isNotEmpty
                              ? Image.network(
                                  player.thumb!,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Icon(Icons.person),
                                  ),
                                )
                              : const SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Icon(Icons.person),
                                ),
                          title: Text(player.name),
                          subtitle: Text('${player.position} - ${player.team}'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailScreenPlayer(),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
