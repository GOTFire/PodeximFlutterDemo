// To parse this JSON data, do
//
//     final openTdb = openTdbFromJson(jsonString);

import 'dart:convert';

OpenTdb openTdbFromJson(String str) => OpenTdb.fromJson(json.decode(str));

String openTdbToJson(OpenTdb data) => json.encode(data.toJson());

class OpenTdb {
  int responseCode;
  List<Result> results;

  OpenTdb({
    this.responseCode,
    this.results,
  });

  factory OpenTdb.fromJson(Map<String, dynamic> json) => new OpenTdb(
    responseCode: json["response_code"],
    results: new List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "response_code": responseCode,
    "results": new List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  String category;
  String type;
  String difficulty;
  String question;
  String correctAnswer;
  List<String> incorrectAnswers;

  Result({
    this.category,
    this.type,
    this.difficulty,
    this.question,
    this.correctAnswer,
    this.incorrectAnswers,
  });

  factory Result.fromJson(Map<String, dynamic> json) => new Result(
    category: json["category"],
    type: json["type"],
    difficulty: json["difficulty"],
    question: json["question"],
    correctAnswer: json["correct_answer"],
    incorrectAnswers: new List<String>.from(json["incorrect_answers"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "category": category,
    "type": type,
    "difficulty": difficulty,
    "question": question,
    "correct_answer": correctAnswer,
    "incorrect_answers": new List<dynamic>.from(incorrectAnswers.map((x) => x)),
  };
}
