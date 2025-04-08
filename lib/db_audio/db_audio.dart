import 'package:audio_clock/db_audio/audio_entity.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBAudio extends GetxService {
  late Database dbBase;

  Future<DBAudio> init() async {
    await createAudioDB();
    return this;
  }

  createAudioDB() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'audio.db');

    dbBase = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await createAudioTable(db);
          await createClockTable(db);
        });
  }

  createAudioTable(Database db) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS audio (id INTEGER PRIMARY KEY, createdTime TEXT, name TEXT, audioPath TEXT)');
  }

  createClockTable(Database db) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS clock (id INTEGER PRIMARY KEY, createdTime TEXT, bg INTEGER, name TEXT, clockTime TEXT, repeat TEXT, audioName TEXT, audioPath TEXT, remind INTEGER)');
  }

  insertAudioData(AudioEntity entity) async {
    final id = await dbBase.insert('audio', {
      'createdTime': entity.createdTime.toIso8601String(),
      'name':entity.name,
      'audioPath': entity.audioPath,
    });
    return id;
  }

  deleteAudioData(int id) async {
    await dbBase.delete('audio', where: 'id = ?', whereArgs: [id]);
  }

  insertClockData(ClockEntity entity) async {
    final id = await dbBase.insert('clock', {
      'createdTime': entity.createdTime.toIso8601String(),
      'bg': entity.bg,
      'name': entity.name,
      'clockTime': entity.clockTime.toIso8601String(),
      'repeat': entity.repeat,
      'audioName': entity.audioName,
      'audioPath': entity.audioPath,
      'remind': entity.remind,
    });
    return id;
  }

  updateClockData(ClockEntity entity) async {
    await dbBase.update('clock', {
      'remind': entity.remind,
    }, where: 'id= ?', whereArgs: [entity.id]);
  }

  deleteClockData(int id) async {
    await dbBase.delete('clock', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<AudioEntity>> getAudioAllData() async {
    var result = await dbBase.query('audio', orderBy: 'createdTime DESC');
    return result.map((e) => AudioEntity.fromJson(e)).toList();
  }

  Future<List<ClockEntity>> getClockAllData() async {
    var result = await dbBase.query('clock', orderBy: 'createdTime DESC');
    return result.map((e) => ClockEntity.fromJson(e)).toList();
  }
}
