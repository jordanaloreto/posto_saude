import 'dart:math';

import 'package:flutter/material.dart';
import 'package:posto_saude/modules/abstract/abstract_manager.dart';
import 'package:posto_saude/modules/enfermeira/pages/enfermeira_form_page.dart';
import 'package:posto_saude/modules/escutaInicial/model/escutaInicial_model.dart';
import 'package:posto_saude/modules/medico/model/medico_model.dart';
import 'package:posto_saude/modules/prontuario/controller/prontuario_controller.dart';
import 'package:posto_saude/modules/prontuario/model/prontuario_model.dart';
import 'package:provider/provider.dart';

class ProntuarioFormPage extends StatefulWidget {
  final EscutaInicial escutaInicial;
  final Prontuario? prontuario;

  ProntuarioFormPage({
    Key? key,
    required this.escutaInicial,
    this.prontuario,
  }) : super(key: key);

  @override
  State<ProntuarioFormPage> createState() => _ProntuarioFormPageState();
}

class _ProntuarioFormPageState extends State<ProntuarioFormPage> {
  final ProntuarioController prontuarioController = ProntuarioController();
  bool canEdit = false; // Flag para controlar se o médico pode editar diagnóstico e tratamento

  @override
  void initState() {
    if (widget.prontuario != null) {
      prontuarioController.diagnosticoController.text = widget.prontuario?.diagnostico ?? '';
      prontuarioController.tratamentoController.text = widget.prontuario?.tratamento ?? '';

      // Se o prontuário já foi salvo, desativa a edição
      canEdit = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.prontuario == null
            ? Text('Cadastro de Prontuário')
            : Text('Visualização de Prontuário'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: prontuarioController.formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // MyCard para informações da Escuta Inicial
                MyCard(
                  title: 'Informações da Escuta Inicial',
                  children: [
                    MyTextField(
                      label: 'Idade',
                      controller: TextEditingController(text: widget.escutaInicial.idade.toString()),
                      enabled: false, keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 12),
                    MyTextField(
                      label: 'Peso',
                      controller: TextEditingController(text: widget.escutaInicial.peso.toString()),
                      enabled: false, keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 12),
                    MyTextField(
                      label: 'Altura',
                      controller: TextEditingController(text: widget.escutaInicial.altura.toString()),
                      enabled: false, keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 12),
                    MyTextField(
                      label: 'Problema',
                      controller: TextEditingController(text: widget.escutaInicial.problema),
                      enabled: false, keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 12),
                    MyTextField(
                      label: 'Enfermeira',
                      controller: TextEditingController(text: widget.escutaInicial.enfermeira.nome),
                      enabled: false, keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 12),
                    MyTextField(
                      label: 'Paciente',
                      controller: TextEditingController(text: widget.escutaInicial.paciente.nome),
                      enabled: false, keyboardType: TextInputType.number,
                    ),
                    
                  ],
                ),
                SizedBox(height: 16),
                // MyCard para informações do Prontuário
                MyCard(
                  title: 'Informações do Prontuário',
                  children: [
                    MyTextField(
                      controller: prontuarioController.diagnosticoController,
                      label: 'Diagnóstico',
                      enabled: canEdit, keyboardType: TextInputType.text,
                    ),
                    SizedBox(height: 12),
                    MyTextField(
                      controller: prontuarioController.tratamentoController,
                      label: 'Tratamento',
                      enabled: canEdit, keyboardType: TextInputType.text,
                    ),
                    DropdownButtonFormField(
                      items: context
                          .read<AbstractManager<Medico>>()
                          .entyties
                          .map((e) => DropdownMenuItem<Medico>(
                              value: e, child: Text(e.nome ?? '-')))
                          .toList(),
                      onChanged: (value) {
                        prontuarioController.selectedMedico = value;
                      },
                      value: prontuarioController.selectedMedico,
                      validator: (value) {
                        if (value == null) {
                          return 'Campo Obrigatório';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // Botão para salvar (ou editar)
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (canEdit) {
                        // Se está editando, salva as alterações
                        prontuarioController.update(context, widget.prontuario!);
                      } else {
                        prontuarioController.save(context,widget.escutaInicial);
                  
                        // Se é uma nova visualização, apenas volta para a tela anterior
                        Navigator.pop(context);
                      }
                    },
                    child: Text(canEdit ? 'Atualizar' : 'Salvar'),
                  ),
                ),
              ],
            ),
          ),
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
    this.validator, required TextInputType keyboardType, required bool enabled,
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

