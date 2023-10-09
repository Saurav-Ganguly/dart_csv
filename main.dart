import 'dart:io';

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print('Usage: dart main.dart <inputFile.csv>');
    exit(1); // 0 : success | non-zero : fail
  }
  final inputFile = arguments.first;
  final lines = File(inputFile).readAsLinesSync();
  print(lines.first);
  lines.removeAt(0); //removes the header
  var totalDurationByTitle = <String, double>{};
  var totalDuration = 0.0;
  for (var line in lines) {
    final values = line.split(','); //split the values on comma
    final durationStr =
        values[3].replaceAll('"', ''); //remove the extra "" from each value
    final duration = double.parse(durationStr);
    var title = values[5].replaceAll('"', '');
    title = title == '' ? 'Unallocated' : title;
    totalDuration += duration;
    if (totalDurationByTitle.containsKey(title)) {
      totalDurationByTitle[title] = totalDurationByTitle[title]! + duration;
    } else {
      totalDurationByTitle[title] = duration;
    }
  }
  for (var value in totalDurationByTitle.entries) {
    print('${value.key} : ${value.value.toStringAsFixed(1)}');
  }
  print('Total Duration : ${totalDuration.toStringAsFixed(1)}');
}
