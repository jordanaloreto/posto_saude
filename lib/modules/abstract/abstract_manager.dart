import 'package:flutter/material.dart';
import 'package:posto_saude/modules/abstract/abstract_entity_model.dart';
import 'package:posto_saude/modules/paciente/model/paciente_model.dart';

class AbstractManager <T extends AbstractEntity> extends ChangeNotifier {
  List<T> _entyties = [];

  List<T> get entyties => _entyties;

  add(T entity) {
    _entyties.add(entity);
    notifyListeners();
  }

  remove(T entity) {
    _entyties.removeWhere((element) => element.id == entity.id);
    notifyListeners();
  }

  edit(T entity) {
    // Encontrar o índice do entity original na lista
    int index = _entyties.indexWhere((element) => element.id == entity.id);

    if (index != -1) {
      // Substituir o entity original pelo entity editado
      _entyties[index] = entity;
      notifyListeners();
    }
  }
}
