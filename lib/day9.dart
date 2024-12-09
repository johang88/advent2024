import 'dart:io';

class File
{
  final int id;
  int index;
  int length;

  File(this.id, this.index, this.length);
}

void day9(List<String> inputLines) {
  final blocks = <int>[];
  final files = <File>[];
  final freelist = <File>[];

  var input = inputLines[0];
  var freeIndex = -1;
  for (var i = 0; i < input.length; i+=2) {
    final size = int.parse(input[i]);
    final free = i + 1 < input.length ? int.parse( input[i + 1]) : 0;
    final id = i ~/ 2;
    final index = blocks.length;

    for (var f = 0; f < size; f++) {
      blocks.add(id);
    }

    files.add(File(id, index, size));

    if (free > 0) freelist.add(File(blocks.length, blocks.length, free));

    if (freeIndex == -1 && free > 0) {
      freeIndex = blocks.length;
    }

    for (var f = 0; f < free; f++) {
      blocks.add(-1);
    }
  }

  // it's compact time (part1)
  var n = blocks.length - 1; // It's never empty at end
  while (freeIndex < n) {
    // Find last block
    while (blocks[n] == -1) {
      n--;
    }

    if (freeIndex < n) {
      blocks[freeIndex] = blocks[n];
      blocks[n] = -1;

      while (freeIndex < blocks.length && blocks[freeIndex] != -1) {
        freeIndex++;
      }
    }
  }

  // le checksum
  var checksum = 0;
  for (var i = 0; i < blocks.length && blocks[i] != -1; i++) {
    checksum += i * blocks[i];
  }

  print(checksum);

  // the return of the compacting
  for (var fileIndex = files.length - 1; fileIndex > 0; fileIndex--)  {
    final file = files[fileIndex];

    // try to find free space
    for (freeIndex = 0; freeIndex < freelist.length && freelist[freeIndex].index < file.index; freeIndex++) {
      if (freelist[freeIndex].length >= file.length) break;
    }

    if (freeIndex < freelist.length && freelist[freeIndex].index < file.index && freelist[freeIndex].length >= file.length) {
      // move file.
      file.index = freelist[freeIndex].index;
      freelist[freeIndex].length = (freelist[freeIndex].index + freelist[freeIndex].length) - (file.index + file.length);
      freelist[freeIndex].index = file.index + file.length;
    }
  }

  checksum = 0;
  for (final file in files) {
    for (var blockIndex = file.index; blockIndex < file.index + file.length; blockIndex++) {
      checksum += blockIndex * file.id;
    }
  }
  print(checksum);

  /*files.sort((a, b) => a.index.compareTo(b.index));
  for (var file in files) {
    for (var i = 0; i < file.length; i++) {
      stdout.write(file.id);
    }
  }*/
}