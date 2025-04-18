import 'package:flutter/material.dart';
import 'package:uts_cinemate/models/team.dart';

class DetailScreenTeam extends StatelessWidget {
  final Team team;

  const DetailScreenTeam({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(team.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: team.badge.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        team.badge,
                        height: 120,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image, size: 100),
                      ),
                    )
                  : const Icon(Icons.shield, size: 100),
            ),
            const SizedBox(height: 20),

            // TEAM NAME
            Center(
              child: Text(
                team.name,
              ),
            ),
            const SizedBox(height: 16),

            // INFO ROWS
            infoTile(Icons.flag, "Short Name", team.shortName),
            infoTile(Icons.sports_soccer, "League", team.league),
            infoTile(Icons.date_range, "Formed Year", team.formedYear),
            infoTile(Icons.stadium, "Stadium", team.stadium),
            infoTile(Icons.location_on, "Location", team.location),

            const SizedBox(height: 20),

            // DESCRIPTION
            const Text(
              'Description:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              team.description.isNotEmpty
                  ? team.description
                  : 'No description available.',
            ),
          ],
        ),
      ),
    );
  }

  Widget infoTile(IconData icon, String title, String value) {
    if (value.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.blueGrey.shade700),
          const SizedBox(width: 10),
          Text(
            "$title: ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
