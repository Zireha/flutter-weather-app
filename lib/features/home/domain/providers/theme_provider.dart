import 'package:flutter_riverpod/flutter_riverpod.dart';

final isDayProvider = StateProvider<int>((ref) => 1);
final weatherCodeProvider = StateProvider<int>(
  (ref) => 1000,
); 
