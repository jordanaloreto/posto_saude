import 'dart:math';

import 'package:flutter/material.dart';
import 'package:posto_saude/modules/abstract/abstract_manager.dart';
import 'package:posto_saude/modules/paciente/model/paciente_lista_manager.dart';
import 'package:posto_saude/modules/paciente/model/paciente_model.dart';
import 'package:provider/provider.dart';

class PacienteControllers extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController documentoController = TextEditingController();
  final TextEditingController nomeMaeController = TextEditingController();
  final TextEditingController cepController = TextEditingController();
  List<Paciente> pacienteFiltro = [];
  Paciente? pacienteSelecionado;

  save(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      Paciente novoPaciente = Paciente(
        id: Random().nextInt(1000),
        nome: nomeController.text,
        documento: documentoController.text,
        nomeMae: nomeMaeController.text,
        cep: cepController.text,
      );

      context.read<AbstractManager<Paciente>>().add(novoPaciente);

      // Adicionar o novo paciente à lista gerenciada

      // Retornar à tela anterior
      Navigator.pop(context);
    }
  }

  update(BuildContext context, Paciente paciente) {
    if (formKey.currentState?.validate() ?? false) {
      paciente.nome = nomeController.text;
      paciente.documento = documentoController.text;
      paciente.nomeMae = nomeMaeController.text;
      paciente.cep = cepController.text;

      context.read<AbstractManager<Paciente>>().edit(paciente);

      // Retornar à tela anterior
      Navigator.pop(context);
    }
  }

  delete(BuildContext context, Paciente paciente) {
    context.read<AbstractManager<Paciente>>().remove(paciente);
  }

  List<Paciente> search(List<Paciente> pacientes, String searchTerm) {
    if (searchTerm.isEmpty) {
      // pacienteFiltro.addAll(
      //     pacientes); // Retorna a lista completa se o termo de pesquisa estiver vazio
      // notifyListeners();
      return pacientes;
    } else {
      searchTerm = searchTerm.toLowerCase();

      // pacienteFiltro.addAll(pacientes.where((paciente) {
      //   return paciente.nome?.toLowerCase().contains(searchTerm) == true ||
      //       paciente.documento?.contains(searchTerm) == true;
      // }).toList());
      // notifyListeners();
      // return pacienteFiltro;
      return pacientes.where((paciente) {
        return paciente.nome?.toLowerCase().contains(searchTerm) == true ||
            paciente.documento?.contains(searchTerm) == true;
      }).toList();
    }
  }
}
