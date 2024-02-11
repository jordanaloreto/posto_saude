import 'package:flutter/material.dart';
import 'package:posto_saude/modules/abstract/abstract_manager.dart';
import 'package:posto_saude/modules/prontuario/controller/prontuario_controller.dart';
import 'package:posto_saude/modules/prontuario/model/prontuario_model.dart';
import 'package:posto_saude/modules/prontuario/pages/prontuario_form_page.dart';
import 'package:posto_saude/modules/escutaInicial/model/escutaInicial_model.dart';
import 'package:posto_saude/modules/prontuario/pages/prontuario_form_page.dart';
import 'package:provider/provider.dart';

class ProntuarioListView extends StatefulWidget {
  @override
  _ProntuarioListViewState createState() => _ProntuarioListViewState();
}

class _ProntuarioListViewState extends State<ProntuarioListView> {
  final ProntuarioController prontuarioController = ProntuarioController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Prontuários'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MyCard(
              title: 'Lista de Prontuários',
              children: [
                DataTable(
                  columns: [
                    DataColumn(label: Text('Diagnóstico')),
                    DataColumn(label: Text('Tratamento')),
                    DataColumn(label: Text('')),
                  ],
                  rows: context
                      .watch<AbstractManager<Prontuario>>()
                      .entyties
                      .map((prontuario) {
                    return DataRow(
                      cells: [
                        DataCell(Text(prontuario.diagnostico ?? 'N/A')),
                        DataCell(Text(prontuario.tratamento ?? 'N/A')),
                        DataCell(
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProntuarioFormPage(
                                    escutaInicial: prontuario.escutaInicial,
                                    prontuario: prontuario,
                                  ),
                                ),
                              );
                            },
                            child: Text('Visualizar'),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
