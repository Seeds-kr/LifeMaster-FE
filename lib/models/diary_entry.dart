class DiaryEntry {
  final DateTime date;
  String diary;
  List<String> gratitude;

  DiaryEntry(this.date, {this.diary = '', List<String>? gratitude})
      : gratitude = gratitude ?? List.generate(5, (_) => '');
}
