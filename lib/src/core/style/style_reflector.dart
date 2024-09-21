import 'package:reflectable/reflectable.dart';

class StyleReflector extends Reflectable {
  const StyleReflector()
      : super(invokingCapability, typeCapability, reflectedTypeCapability);
}
const styleReflector = StyleReflector();
