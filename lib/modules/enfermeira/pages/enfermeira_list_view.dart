import 'package:flutter/material.dart';
import 'package:posto_saude/modules/abstract/abstract_manager.dart';
import 'package:posto_saude/modules/enfermeira/controller/enfermeira_controller.dart';
import 'package:posto_saude/modules/enfermeira/model/enfermeira_model.dart';
import 'package:posto_saude/modules/enfermeira/pages/enfermeira_form_page.dart';
import 'package:provider/provider.dart';

class EnfermeiraListView extends StatefulWidget {
  // final List<Enfermeira> enfermeira;

  final EnfermeiraControllers enfermeiraControllers = EnfermeiraControllers();

  @override
  _EnfermeiraListViewState createState() => _EnfermeiraListViewState();
}

class _EnfermeiraListViewState extends State<EnfermeiraListView> {
  List<Enfermeira> enfermeira = [];

  final EnfermeiraControllers enfermeiraControllers = EnfermeiraControllers();


  @override
  void initState() {
    super.initState();
    // Inicialize a lista de enfermeira no estado do widget
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Enfermeiras'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MyCard(
              title: 'Lista de Enfermeiras',
              children: [
                DataTable(
                  columns: [
                    DataColumn(label: Text('Nome')),
                    DataColumn(label: Text('Documento')),
                    DataColumn(label: Text('')),
                    DataColumn(label: Text('')),
                  ],
                  rows: context
                      .watch<AbstractManager<Enfermeira>>()
                      .entyties
                      .map((enfermeira) {
                    return DataRow(
                      cells: [
                        DataCell(Text(enfermeira.nome ?? 'N/A')),
                        DataCell(Text(enfermeira.documento ?? 'N/A')),
                        DataCell(
                          ElevatedButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EnfermeiraFormPage(
                                        enfermeira: enfermeira,
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
                                          enfermeiraControllers.delete(context, enfermeira); // Chamar o método de deletar
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
                // Navegar para a página de formulário de enfermeira
                Navigator.push<Enfermeira>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EnfermeiraFormPage(),
                  ),
                );
              },
              child: Text('Cadastrar Enfermeira'),
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
