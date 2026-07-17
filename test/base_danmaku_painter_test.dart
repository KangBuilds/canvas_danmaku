import 'package:canvas_danmaku/base_danmaku_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

final class _Painter extends BaseDanmakuPainter {
  _Painter(ValueNotifier<double> repaint)
      : super(
          length: 1,
          fontSize: 16,
          fontWeight: 4,
          strokeWidth: 1,
          running: true,
          tick: repaint.value,
          repaint: repaint,
        );

  @override
  void paint(Canvas canvas, Size size) {}
}

void main() {
  test('reads the latest tick without replacing the painter', () {
    final notifier = ValueNotifier(1.25);
    final painter = _Painter(notifier);
    var repaints = 0;
    void onRepaint() => repaints++;
    painter.addListener(onRepaint);

    notifier.value = 2.5;

    expect(painter.tick, 2.5);
    expect(repaints, 1);
    painter.removeListener(onRepaint);
    notifier.dispose();
  });
}
