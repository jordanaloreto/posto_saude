import 'package:flutter/material.dart';
import 'package:posto_saude/modules/enfermeira/pages/enfermeira_form_page.dart';
import 'package:posto_saude/modules/medico/model/medico_model.dart';
import 'package:posto_saude/modules/medico/controller/medico_controller.dart';


class MedicoFormPage extends StatefulWidget {
  final Medico? medico;
  MedicoFormPage({
    Key? key,
    this.medico,
  }) : super(key: key);

  @override
  State<MedicoFormPage> createState() => _MedicoFormPageState();
}

class _MedicoFormPageState extends State<MedicoFormPage> {
  // final TextEditingController nomeController = TextEditingController();
  final MedicoController  medicoControllers = MedicoController();

  @override
  void initState() {
    if (widget.medico != null) {
      medicoControllers.nomeController.text = widget.medico?.nome ?? '';
      medicoControllers.documentoController.text = widget.medico?.documento ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Médico'),
      ),
      body: Form(
        key: medicoControllers.formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MyTextField(
                      controller: medicoControllers.nomeController,
                      label: 'Nome',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Campo obrigatório";
                        }
                        return null;
                      },
                    ),
              SizedBox(height: 20),
              MyTextField(
                      controller: medicoControllers.documentoController,
                      label: 'Documento',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Campo obrigatório";
                        }
                        return null;
                      },
                    ),
              SizedBox(height: 20),
             Center(
                child: ElevatedButton(
                  onPressed: () => widget.medico == null
                      ? medicoControllers.save(context)
                      : medicoControllers.update(context, widget.medico!),
                  child: Text('Salvar'),
                ),
              ),
            ],
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


