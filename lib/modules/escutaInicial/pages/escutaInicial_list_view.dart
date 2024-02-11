import 'package:flutter/material.dart';
import 'package:posto_saude/modules/abstract/abstract_manager.dart';
import 'package:posto_saude/modules/escutaInicial/controller/escutaInicial_controller.dart';
import 'package:posto_saude/modules/escutaInicial/model/escutaInicial_model.dart';
import 'package:posto_saude/modules/escutaInicial/pages/escutaInicial_form_page.dart';
import 'package:provider/provider.dart';

class EscutaInicialListView extends StatefulWidget {
  @override
  _EscutaInicialListViewState createState() => _EscutaInicialListViewState();
}

class _EscutaInicialListViewState extends State<EscutaInicialListView> {
  final EscutaInicialControllers escutaInicialControllers = EscutaInicialControllers();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Escuta Inicial'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MyCard(
              title: 'Lista de Escuta Inicial',
              children: [
                DataTable(
                  columns: [
                    DataColumn(label: Text('Idade')),
                    DataColumn(label: Text('Peso')),
                    DataColumn(label: Text('Altura')),
                    DataColumn(label: Text('Problema')),
                    DataColumn(label: Text('')),
                    DataColumn(label: Text('')),
                  ],
                  rows: context
                      .watch<AbstractManager<EscutaInicial>>()
                      .entyties
                      .map((escutaInicial) {
                    return DataRow(
                      cells: [
                        DataCell(Text(escutaInicial.idade.toString())),
                        DataCell(Text(escutaInicial.peso.toString())),
                        DataCell(Text(escutaInicial.altura.toString())),
                        DataCell(Text(escutaInicial.problema ?? 'N/A')),
                        DataCell(
                          ElevatedButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EscutaInicialFormPage(
                                  escutaInicial: escutaInicial,
                                ),
                              ),
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
                                    content: Text('Tem certeza que deseja deletar a escuta inicial?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context); // Fechar o diálogo
                                        },
                                        child: Text('Cancelar'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          escutaInicialControllers.delete(context, escutaInicial); // Chamar o método de deletar
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
                // Navegar para a página de formulário de escuta inicial
                Navigator.push<EscutaInicial>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EscutaInicialFormPage(),
                  ),
                );
              },
              child: Text('Nova Escuta Inicial'),
            ),
          ],
        ),
      ),
    );
  }
}
