import 'dart:io';

import 'package:collection/collection.dart';

void main() {
//  var w = 'anagram';
//  var q = 'anAgraAM';
  print("Text 1: ");
  String text1 = stdin.readLineSync();
  print("Text 2: ");
  String text2 = stdin.readLineSync();

  var x = text1
      .toLowerCase() //to void capitalism
      .replaceAll(new RegExp(r"\s+"), "") // to remove space
      .codeUnits // to convert
      .toSet() // to remove redundancy
      .toList(); // to list
  var y = text2
      .toLowerCase()
      .replaceAll(new RegExp(r"\s+"), "")
      .codeUnits
      .toSet()
      .toList();
  print(x);
  print(y);
  Function unOrdDeepEq = const DeepCollectionEquality.unordered().equals;
  if (unOrdDeepEq(x, y))
    print("Anagrams");
  else
    print("Not Anagrams");
}
