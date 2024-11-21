import 'carbonBuffer.dart';
import 'hatchBuffer.dart';
import 'punchedSheetBuffer.dart';

Future<bool> initBuffers() async {
  await carbonBufferInit();
  await hatchBufferInit();
  await punchedSheetBufferInit();

  return true;
}
