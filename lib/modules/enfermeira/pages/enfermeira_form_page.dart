import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:posto_saude/modules/enfermeira/controller/enfermeira_controller.dart';
import 'package:posto_saude/modules/enfermeira/model/enfermeira_model.dart';

class EnfermeiraFormPage extends StatefulWidget {
  final Enfermeira? enfermeira;
  EnfermeiraFormPage({
    Key? key,
    this.enfermeira,
  }) : super(key: key);

  @override
  State<EnfermeiraFormPage> createState() => _EnfermeiraFormPageState();
}

class _EnfermeiraFormPageState extends State<EnfermeiraFormPage> {
  // final TextEditingController nomeController = TextEditingController();
  final EnfermeiraControllers enfermeiraControllers = EnfermeiraControllers();

  @override
  void initState() {
    if (widget.enfermeira != null) {
      enfermeiraControllers.nomeController.text = widget.enfermeira?.nome ?? '';
      enfermeiraControllers.documentoController.text = widget.enfermeira?.documento ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.enfermeira == null
            ? Text('Cadastro de Enfermeira')
            : Text('Edição de Enfermeira'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Form(
              key: enfermeiraControllers.formKey,
              child: MyCard(
                title: 'Informações do Enfermeira',
                children: [
                  MyTextField(
                    controller: enfermeiraControllers.nomeController,
                    label: 'Nome',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Campo obrigatório";
                      }
                      return null;
                    }, keyboardType: TextInputType.name, enabled: true,
                  ),
                  SizedBox(height: 12),
                  MyTextField(
                    controller: enfermeiraControllers.documentoController,
                    label: 'Documento (CPF)',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Campo obrigatório";
                      }
                      return null;
                    }, keyboardType: TextInputType.number, enabled: true,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () => widget.enfermeira == null
                    ? enfermeiraControllers.save(context)
                    : enfermeiraControllers.update(context, widget.enfermeira!),
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
