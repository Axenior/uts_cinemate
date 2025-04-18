import 'package:flutter/material.dart';
import 'package:uts_cinemate/models/player.dart';

class DetailScreenPlayer extends StatelessWidget {
  final Player player;

  const DetailScreenPlayer({super.key, required this.player});

  Widget _buildInfoTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title: ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Expanded(
            child: Text(
              value.isNotEmpty ? value : '-',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(player.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: player.thumb != null && player.thumb!.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        player.thumb!,
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.person, size: 150),
                      ),
                    )
                  : const Icon(Icons.person, size: 150),
            ),
            const SizedBox(height: 20),
            Text(
              player.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                player.position,
                style:
                    const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
            ),
            const Divider(height: 30),
            _buildInfoTile("Team", player.team),
            _buildInfoTile("Sport", player.sport),
            _buildInfoTile("Nationality", player.nationality),
            _buildInfoTile("Date of Birth", player.dateBorn),
            _buildInfoTile("Status", player.status),
            _buildInfoTile("Gender", player.gender),
          ],
        ),
      ),
    );
  }
}
