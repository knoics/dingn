import 'package:dingn/interface.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ProviderModel extends ChangeNotifier {
  ProviderModel();
  ModelState _state = ModelState.Done;
  ModelState get state => _state;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  void setState(ModelState viewState) {
    _state = viewState;
    notifyListeners();
  }
}

enum ModelState { Progress, Done }

class ItemList<T> {
  ItemList(this.items, {this.hasMoreData = true});
  final List<T> items;
  int? index;
  T get item => items[index!];
  T operator [](int i) => items[i];
  bool hasMoreData;
}

abstract class ListProviderModel<T> extends ProviderModel {
  ListProviderModel(
      {this.collectionName = '',
      this.requestBatchSize = 0,
      this.presetItemKeys = const []}) {
    setActiveKey('1');
  }
  T dictToItem(Map<String, dynamic>? data);
  Future<List<Map<String, dynamic>>> loadDataFromDb();
  Future<List<T>> postLoad(List<T> items);
  Future<T> postFind(T item);

  List<String> presetItemKeys;
  int presetItemIndex = 0;
  final int requestBatchSize;

  final DBService db = GetIt.instance.get<DBService>();
  final Map<String, ItemList<T>> _items = {};
  List<T> get items => _items[_activeKey]!.items;
  int get itemCount => items.length;
  T get activeItem => _items[_activeKey]!.item;
  int? get activeIndex => _items[_activeKey]!.index;
  set activeIndex(int? index) {
    _items[_activeKey]!.index = index;
  }

  bool get hasMoreData => _items[_activeKey]!.hasMoreData;

  final String collectionName;
  String _activeKey = '';
  String get activeKey => _activeKey;

  void setPresetItemKeys(List<String> itemKeys) {
    presetItemIndex = 0;
    presetItemKeys = itemKeys;
    //print('hello reset keys: $itemKeys');
    _items[_activeKey] = ItemList([]);
    notifyListeners();
  }

  void setActiveKey(String activeKey) {
    if (activeKey != _activeKey) {
      _activeKey = activeKey;
      _items.putIfAbsent(_activeKey, () => ItemList([]));
      notifyListeners();
    }
  }

  void _add(List<T> itemList) {
    items.addAll(itemList);
    //print('hello items: $items, added $itemList');
    notifyListeners();
  }

  Future<void> loadData() async {
    if (!hasMoreData) {
      return;
    }
    List<T> dt = [];
    if (presetItemKeys.isNotEmpty) {
      if (presetItemIndex < presetItemKeys.length) {
        final nextItem = await find(presetItemKeys[presetItemIndex]);
        dt = [nextItem];
        presetItemIndex++;
      }
    } else {
      final dicts = await loadDataFromDb();
      dt = await postLoad(dicts.map((dict) => dictToItem(dict)).toList());
    }
    _items[_activeKey]!.hasMoreData = dt.length == requestBatchSize;
    //  print('loaded items: ${dt.length}, $requestBatchSize');
    _add(dt);
  }

  Future<T> find(String key) async {
    final data = await db.getDoc(collectionName, key);
    final item = dictToItem(data);
    return await postFind(item);
  }
}
