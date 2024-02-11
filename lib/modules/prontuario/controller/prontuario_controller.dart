import 'dart:math';

import 'package:flutter/material.dart';
import 'package:posto_saude/modules/abstract/abstract_manager.dart';
import 'package:posto_saude/modules/escutaInicial/model/escutaInicial_model.dart';
import 'package:posto_saude/modules/medico/model/medico_model.dart';
import 'package:posto_saude/modules/prontuario/model/prontuario_model.dart';
import 'package:provider/provider.dart';

class ProntuarioController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController alturaController = TextEditingController();
  final TextEditingController problemaController = TextEditingController();
  final TextEditingController idadeController = TextEditingController();
  final TextEditingController diagnosticoController = TextEditingController();
  final TextEditingController tratamentoController = TextEditingController();

  Medico? selectedMedico;

  save(BuildContext context, EscutaInicial escutaInicial) {
    if (formKey.currentState?.validate() ?? false) {
      Prontuario novoProntuario = Prontuario(
        id: Random().nextInt(1000),
        escutaInicial: escutaInicial,
        diagnostico: diagnosticoController.text,
        tratamento: tratamentoController.text,
        medico: selectedMedico!,
      );

      context.read<AbstractManager<Prontuario>>().add(novoProntuario);
      Navigator.pop(context);
    }
  }

  update(BuildContext context, Prontuario prontuario) {
    if (formKey.currentState?.validate() ?? false) {
      prontuario.diagnostico = diagnosticoController.text;
      prontuario.tratamento = tratamentoController.text;
      prontuario.medico = selectedMedico!;

      context.read<AbstractManager<Prontuario>>().edit(prontuario);

      // Retornar à tela anterior
      Navigator.pop(context);
    }
  }

  delete(BuildContext context, Prontuario prontuario) {
    context.read<AbstractManager<Prontuario>>().remove(prontuario);
  }
}
