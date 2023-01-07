import 'dart:convert' as convert;

List<Item> jsonListDecode<Item>(
  String jsonListString,
  Item Function(dynamic json) itemFromJson,
) {
  final List<dynamic> dynamicList = convert.jsonDecode(jsonListString);
  return dynamicList.map(
    (dynamicItem) {
      final jsonStringItem = convert.jsonEncode(dynamicItem);
      final json = convert.jsonDecode(jsonStringItem);
      return itemFromJson(json);
    },
  ).toList();
}
