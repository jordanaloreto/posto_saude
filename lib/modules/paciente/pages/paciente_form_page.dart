import 'dart:math';

import 'package:flutter/material.dart';
import 'package:posto_saude/modules/abstract/abstract_manager.dart';
import 'package:provider/provider.dart';
import 'package:posto_saude/modules/paciente/controller/paciente_controller.dart';
import 'package:posto_saude/modules/paciente/model/paciente_model.dart';

class PacienteFormPage extends StatefulWidget {
  final Paciente? paciente;
  PacienteFormPage({
    Key? key,
    this.paciente,
  }) : super(key: key);

  @override
  State<PacienteFormPage> createState() => _PacienteFormPageState();
}

class _PacienteFormPageState extends State<PacienteFormPage> {
  // final TextEditingController nomeController = TextEditingController();
  final PacienteControllers pacienteControllers = PacienteControllers();

  @override
  void initState() {
    if (widget.paciente != null) {
      pacienteControllers.nomeController.text = widget.paciente?.nome ?? '';
      pacienteControllers.nomeMaeController.text =
          widget.paciente?.nomeMae ?? '';
      pacienteControllers.cepController.text = widget.paciente?.cep ?? '';
      pacienteControllers.documentoController.text =
          widget.paciente?.documento ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.paciente == null
            ? Text('Cadastro de Paciente')
            : Text('Edição de Paciente'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Form(
              key: pacienteControllers.formKey,
              child: MyCard(
                title: 'Informações do Paciente',
                children: [
                  MyTextField(
                    controller: pacienteControllers.nomeController,
                    label: 'Nome',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Campo obrigatório";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 12),
                  MyTextField(
                    controller: pacienteControllers.documentoController,
                    label: 'Documento (CPF)',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Campo obrigatório";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 12),
                  MyTextField(
                    controller: pacienteControllers.nomeMaeController,
                    label: 'Nome da Mãe',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Campo obrigatório";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 12),
                  MyTextField(
                    controller: pacienteControllers.cepController,
                    label: 'CEP',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Campo obrigatório";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () => widget.paciente == null
                    ? pacienteControllers.save(context)
                    : pacienteControllers.update(context, widget.paciente!),
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
