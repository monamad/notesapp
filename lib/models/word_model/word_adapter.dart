import 'package:hive_flutter/hive_flutter.dart';
import 'package:wordapp/models/word_model/word.dart';

class WordAdapter extends TypeAdapter<Word> {
  @override
  Word read(BinaryReader reader) {
    return Word(
      theWord: reader.readString(),
      id: reader.readInt(),
      color: reader.readInt(),
      isarabic: reader.readBool(),
      arsimilarWords: reader.readStringList(),
      engsimilarWords: reader.readStringList(),
      arexpamples: reader.readStringList(),
      engexpamples: reader.readStringList(),
    );
  }

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, Word obj) {
    writer.writeString(obj.theWord);
    writer.writeInt(obj.id);
    writer.writeInt(obj.color);
    writer.writeBool(obj.isarabic);
    writer.writeStringList(obj.arsimilarWords);
    writer.writeStringList(obj.engsimilarWords);
    writer.writeStringList(obj.arexpamples);
    writer.writeStringList(obj.engexpamples);
  }
}
