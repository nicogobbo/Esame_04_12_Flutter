class Exercise {
  Exercise({
    required this.name,
    required this.score,
    required this.submittedAt,
  });

  String name;
  int score; 
  DateTime submittedAt;

  int get isPassed {
    return score >= 60 ? 1 : 0;
  }
}

List<Exercise> passedOnly(List<Exercise> exercises) {
  List<Exercise> result = [];
  for (var ex in exercises) {
    if (ex.isPassed == 1) {
      result.add(ex);
    }
  }
  return result;
}

  double averageScore(List<Exercise> exercises) {
  if (exercises.isEmpty) {
    return 0.0;
  }
  int sum = 0;
  for (var ex in exercises) {
    sum += ex.score;
  }
  return sum / exercises.length;
}

String bestStudent(List<Exercise> exercises) {
  if (exercises.isEmpty) {
    throw ArgumentError("non va bene, lista vuota");
  }
  Exercise best = exercises[0];
  for (int i = 1; i < exercises.length; i++) {
    if (exercises[i].score > best.score) {
      best = exercises[i];
    }
  }
  return best.name;
}
