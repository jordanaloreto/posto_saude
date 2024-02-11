import 'dart:math';

import 'package:flutter/material.dart';
import 'package:posto_saude/modules/abstract/abstract_manager.dart';
import 'package:posto_saude/modules/escutaInicial/model/escutaInicial_model.dart';
import 'package:posto_saude/modules/paciente/model/paciente_model.dart'; // Importe a classe Paciente
import 'package:posto_saude/modules/enfermeira/model/enfermeira_model.dart'; // Importe a classe Enfermeira
import 'package:posto_saude/modules/prontuario/model/prontuario_model.dart';
import 'package:posto_saude/modules/prontuario/pages/prontuario_form_page.dart';
import 'package:provider/provider.dart';

class EscutaInicialControllers extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController alturaController = TextEditingController();
  final TextEditingController problemaController = TextEditingController();
  final TextEditingController idadeController = TextEditingController();
  // final List<Paciente> pacientes; // Sua lista de pacientes
  // final List<Enfermeira> enfermeiras; // Sua lista de enfermeiras

  Paciente? selectedPaciente; // Paciente selecionado no dropdown
  Enfermeira? selectedEnfermeira; // Enfermeira selecionada no dropdown

  // EscutaInicialControllers({
  //   required this.pacientes,
  //   required this.enfermeiras,
  // });

  // save(BuildContext context) {
  //   if (formKey.currentState?.validate() ?? false) {
  //     EscutaInicial novoEscutaInicial = EscutaInicial(
  //       id: Random().nextInt(1000),
  //       peso: double.parse(pesoController.text),
  //       altura: double.parse(alturaController.text),
  //       problema: problemaController.text,
  //       idade: int.parse(idadeController.text),
  //       // paciente: selectedPaciente,
  //       // enfermeira: selectedEnfermeira,
  //     );

  //     context.read<AbstractManager<EscutaInicial>>().add(novoEscutaInicial);
  //     Navigator.pop(context);
  //   }
  // }

  save(BuildContext context) {
  if (formKey.currentState?.validate() ?? false) {
    EscutaInicial novaEscutaInicial = EscutaInicial(
      id: Random().nextInt(1000),
      peso: double.parse(pesoController.text),
      altura: double.parse(alturaController.text),
      problema: problemaController.text,
      idade: int.parse(idadeController.text),
      paciente: selectedPaciente!,
      enfermeira: selectedEnfermeira!,
    );

    // Adiciona a EscutaInicial
    context.read<AbstractManager<EscutaInicial>>().add(novaEscutaInicial);

    // Navega para a tela de formulário de Prontuario passando a mesma instância de EscutaInicial
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProntuarioFormPage(
          escutaInicial: novaEscutaInicial,
        ),
      ),
    );
  }
}

  update(BuildContext context, EscutaInicial escutaInicial) {
    if (formKey.currentState?.validate() ?? false) {
      escutaInicial.peso = double.parse(pesoController.text);
      escutaInicial.altura = double.parse(alturaController.text);
      escutaInicial.problema = problemaController.text;
      escutaInicial.idade = int.parse(idadeController.text);
      escutaInicial.paciente = selectedPaciente!;
      escutaInicial.enfermeira = selectedEnfermeira!;

      context.read<AbstractManager<EscutaInicial>>().edit(escutaInicial);

      // Retornar à tela anterior
      Navigator.pop(context);
    }
  }

  delete(BuildContext context, EscutaInicial escutaInicial) {
    context.read<AbstractManager<EscutaInicial>>().remove(escutaInicial);
  }
}
