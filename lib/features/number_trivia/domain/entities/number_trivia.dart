import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class NumberTrivia extends Equatable { //An abstract class that helps to implement equality without needing to explicitly override == and hashCode.
  final String text;
  final int number;

  NumberTrivia({
    @required this.text,
    @required this.number
    }) : super([text, number]); //Equatable needs to know which properties to make equality happen

}