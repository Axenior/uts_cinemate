class Leaderboard {
  final String idStanding;
  final int rank;
  final String team;
  final String badge;
  final int played;
  final int win;
  final int loss;
  final int draw;
  final int goalsFor;
  final int goalsAgainst;
  final int goalDifference;
  final int points;

  Leaderboard({
    required this.idStanding,
    required this.rank,
    required this.team,
    required this.badge,
    required this.played,
    required this.win,
    required this.loss,
    required this.draw,
    required this.goalsFor,
    required this.goalsAgainst,
    required this.goalDifference,
    required this.points,
  });

  factory Leaderboard.fromJson(Map<String, dynamic> json) {
    return Leaderboard(
      idStanding: json['idStanding'],
      rank: int.parse(json['intRank']),
      team: json['strTeam'],
      badge: json['strBadge'],
      played: int.parse(json['intPlayed']),
      win: int.parse(json['intWin']),
      loss: int.parse(json['intLoss']),
      draw: int.parse(json['intDraw']),
      goalsFor: int.parse(json['intGoalsFor']),
      goalsAgainst: int.parse(json['intGoalsAgainst']),
      goalDifference: int.parse(json['intGoalDifference']),
      points: int.parse(json['intPoints']),
    );
  }
}
