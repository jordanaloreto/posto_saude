import 'package:flutter/material.dart';
import 'package:posto_saude/modules/abstract/abstract_manager.dart';
import 'package:posto_saude/modules/medico/controller/medico_controller.dart';
import 'package:posto_saude/modules/medico/model/medico_model.dart';
import 'package:posto_saude/modules/medico/pages/medico_form_page.dart';
import 'package:provider/provider.dart';

class MedicoListView extends StatefulWidget {
  // final List<Medico> medico;

  final MedicoController medicoController = MedicoController();

  @override
  _MedicoListViewState createState() => _MedicoListViewState();
}

class _MedicoListViewState extends State<MedicoListView> {
  List<Medico> medico = [];

  final MedicoController medicoController = MedicoController();


  @override
  void initState() {
    super.initState();
    // Inicialize a lista de medico no estado do widget
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Medicos'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MyCard(
              title: 'Lista de Medicos',
              children: [
                DataTable(
                  columns: [
                    DataColumn(label: Text('Nome')),
                    DataColumn(label: Text('Documento')),
                    DataColumn(label: Text('')),
                    DataColumn(label: Text('')),
                  ],
                  rows: context
                      .watch<AbstractManager<Medico>>()
                      .entyties
                      .map((medico) {
                    return DataRow(
                      cells: [
                        DataCell(Text(medico.nome ?? 'N/A')),
                        DataCell(Text(medico.documento ?? 'N/A')),
                        DataCell(
                          ElevatedButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MedicoFormPage(
                                       medico: medico,
                                      )),
                            ),
                            child: Text('Editar'),
                          ),
                        ),
                        DataCell(
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Confirmação'),
                                    content: Text('Tem certeza que deseja deletar o paciente?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context); // Fechar o diálogo
                                        },
                                        child: Text('Cancelar'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          medicoController.delete(context, medico); // Chamar o método de deletar
                                          Navigator.pop(context); // Fechar o diálogo
                                        },
                                        child: Text('Deletar'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text('Deletar'),
                          ),
                        )
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 16), // Espaçamento entre a tabela e o botão
            ElevatedButton(
              onPressed: () async {
                // Navegar para a página de formulário de medico
                Navigator.push<Medico>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MedicoFormPage(),
                  ),
                );
              },
              child: Text('Cadastrar Medico'),
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
