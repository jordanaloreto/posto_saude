import 'dart:math';

import 'package:flutter/material.dart';
import 'package:posto_saude/modules/abstract/abstract_manager.dart';
import 'package:posto_saude/modules/enfermeira/model/enfermeira_model.dart';
import 'package:provider/provider.dart';

class EnfermeiraControllers {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController documentoController = TextEditingController();

  save(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      Enfermeira novoEnfermeira = Enfermeira(
        id: Random().nextInt(1000),
        nome: nomeController.text,
        documento: documentoController.text,
      );

      context.read<AbstractManager<Enfermeira>>().add(novoEnfermeira);
      // Adicionar o novo paciente à lista gerenciada
      // Retornar à tela anterior
      Navigator.pop(context);
    }
  }

  update(BuildContext context, Enfermeira paciente) {
    if (formKey.currentState?.validate() ?? false) {
      paciente.nome = nomeController.text;
      paciente.documento = documentoController.text;
      
      context.read<AbstractManager<Enfermeira>>().edit(paciente);
      // Retornar à tela anterior
      Navigator.pop(context);
    }
  }

  delete(BuildContext context, Enfermeira enfermeira) {
      context.read<AbstractManager<Enfermeira>>().remove(enfermeira);
  }
}
