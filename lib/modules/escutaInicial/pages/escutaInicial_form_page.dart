import 'dart:math';

import 'package:flutter/material.dart';
import 'package:posto_saude/modules/abstract/abstract_manager.dart';
import 'package:posto_saude/modules/enfermeira/model/enfermeira_model.dart';
import 'package:posto_saude/modules/enfermeira/pages/enfermeira_form_page.dart';
import 'package:posto_saude/modules/escutaInicial/controller/escutaInicial_controller.dart';
import 'package:posto_saude/modules/paciente/model/paciente_model.dart';
import 'package:provider/provider.dart';
import 'package:posto_saude/modules/escutaInicial/model/escutaInicial_model.dart';

class EscutaInicialFormPage extends StatefulWidget {
  final EscutaInicial? escutaInicial;

  EscutaInicialFormPage({
    Key? key,
    this.escutaInicial,
  }) : super(key: key);

  @override
  State<EscutaInicialFormPage> createState() => _EscutaInicialFormPageState();
}

class _EscutaInicialFormPageState extends State<EscutaInicialFormPage> {
  final EscutaInicialControllers escutaInicialControllers =
      EscutaInicialControllers();
  @override
  void initState() {
    if (widget.escutaInicial != null) {
      escutaInicialControllers.idadeController.text =
          widget.escutaInicial?.idade.toString() ?? '';
      escutaInicialControllers.pesoController.text =
          widget.escutaInicial?.peso.toString() ?? '';
      escutaInicialControllers.alturaController.text =
          widget.escutaInicial?.altura.toString() ?? '';
      escutaInicialControllers.problemaController.text =
          widget.escutaInicial?.problema ?? '';
      escutaInicialControllers.selectedEnfermeira =
          widget.escutaInicial?.enfermeira;
      escutaInicialControllers.selectedPaciente =
          widget.escutaInicial?.paciente;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.escutaInicial == null
            ? Text('Cadastro de Escuta Inicial')
            : Text('Edição de Escuta Inicial'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Form(
              key: escutaInicialControllers.formKey,
              child: MyCard(
                title: 'Informações da Escuta Inicial',
                children: [
                  MyTextField(
                    controller: escutaInicialControllers.idadeController,
                    label: 'Idade',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Campo obrigatório";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 12),
                  MyTextField(
                    controller: escutaInicialControllers.pesoController,
                    label: 'Peso',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Campo obrigatório";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 12),
                  MyTextField(
                    controller: escutaInicialControllers.alturaController,
                    label: 'Altura',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Campo obrigatório";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 12),
                  MyTextField(
                    controller: escutaInicialControllers.problemaController,
                    label: 'Problema',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Campo obrigatório";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                  ),
                  DropdownButtonFormField(
                    items: context
                        .read<AbstractManager<Paciente>>()
                        .entyties
                        .map((e) => DropdownMenuItem<Paciente>(
                            value: e, child: Text(e.nome ?? '-')))
                        .toList(),
                    onChanged: (value) {
                      escutaInicialControllers.selectedPaciente = value;
                    },
                    value: escutaInicialControllers.selectedPaciente,
                    validator: (value) {
                      if (value == null) {
                        return 'Campo Obrigatório';
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField(
                      items: context
                          .read<AbstractManager<Enfermeira>>()
                          .entyties
                          .map((e) => DropdownMenuItem<Enfermeira>(
                              value: e, child: Text(e.nome ?? '-')))
                          .toList(),
                      onChanged: (value) {
                        escutaInicialControllers.selectedEnfermeira = value;
                      },
                      value: escutaInicialControllers.selectedEnfermeira,
                      validator: (value) {
                      if (value == null) {
                        return 'Campo Obrigatório';
                      }
                      return null;
                    },),
                ],
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () => widget.escutaInicial == null
                    ? escutaInicialControllers.save(context)
                    : escutaInicialControllers.update(
                        context, widget.escutaInicial!),
                child: Text('Salvar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  MyCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;

  MyTextField({
    required this.controller,
    required this.label,
    this.validator,
    required TextInputType keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      validator: validator,
    );
  }
}
