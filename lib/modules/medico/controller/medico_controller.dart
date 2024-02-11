import 'dart:math';

import 'package:flutter/material.dart';
import 'package:posto_saude/modules/abstract/abstract_manager.dart';
import 'package:posto_saude/modules/medico/model/medico_model.dart';
import 'package:provider/provider.dart';

class MedicoController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController documentoController = TextEditingController();

  save(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      Medico novoMedico = Medico(
        id: Random().nextInt(1000),
        nome: nomeController.text,
        documento: documentoController.text,
      );

      context.read<AbstractManager<Medico>>().add(novoMedico);
      // Adicionar o novo medico à lista gerenciada
      // Retornar à tela anterior
      Navigator.pop(context);
    }
  }

  update(BuildContext context, Medico medico) {
    if (formKey.currentState?.validate() ?? false) {
      medico.nome = nomeController.text;
      medico.documento = documentoController.text;
      
      context.read<AbstractManager<Medico>>().edit(medico);
      // Retornar à tela anterior
      Navigator.pop(context);
    }
  }

  delete(BuildContext context, Medico medico) {
      context.read<AbstractManager<Medico>>().remove(medico);
  }
}
