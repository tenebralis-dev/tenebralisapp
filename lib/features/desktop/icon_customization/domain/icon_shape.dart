/// icon 形状（全局）。
///
/// 说明：用于控制 icon 图片/占位的裁切形状。
enum IconShape {
  square,
  roundedRect,
  superRoundedRect,
  circle,
}

extension IconShapeX on IconShape {
  String get id => name;

  static IconShape fromId(String? id) {
    return IconShape.values.firstWhere(
      (e) => e.name == id,
      orElse: () => IconShape.roundedRect,
    );
  }
}
