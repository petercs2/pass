import 'package:intl/intl.dart';

class AudioEntity {
  int id;
  DateTime createdTime;
  String name;
  String audioPath;

  AudioEntity({
    required this.id,
    required this.createdTime,
    required this.name,
    required this.audioPath,
  });

  factory AudioEntity.fromJson(Map<String, dynamic> json) {
    return AudioEntity(
      id: json['id'],
      createdTime: DateTime.parse(json['createdTime']),
      name: json['name'],
      audioPath: json['audioPath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdTime': createdTime.toIso8601String(),
      'name': name,
      'audioPath': audioPath,
    };
  }
}

class ClockEntity {
  int id;
  DateTime createdTime;
  int bg;
  String name;
  DateTime clockTime;
  String repeat;
  String audioName;
  String audioPath;
  int remind;

  ClockEntity({
    required this.id,
    required this.createdTime,
    required this.bg,
    required this.name,
    required this.clockTime,
    required this.repeat,
    required this.audioName,
    required this.audioPath,
    required this.remind,
  });

  factory ClockEntity.fromJson(Map<String, dynamic> json) {
    return ClockEntity(
      id: json['id'],
      createdTime: DateTime.parse(json['createdTime']),
      bg: json['bg'],
      name: json['name'],
      clockTime: DateTime.parse(json['clockTime']),
      repeat: json['repeat'],
      audioName: json['audioName'],
      audioPath: json['audioPath'],
      remind: json['remind'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdTime': createdTime.toIso8601String(),
      'bg': bg,
      'name': name,
      'clockTime': clockTime.toIso8601String(),
      'repeat': repeat,
      'audioName': audioName,
      'audioPath': audioPath,
      'remind': remind,
    };
  }

  String get clockTimeString => DateFormat('HH:mm').format(clockTime);

}

