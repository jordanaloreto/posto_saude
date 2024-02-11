
import 'package:flutter/material.dart';
import 'package:posto_saude/modules/abstract/abstract_manager.dart';
import 'package:posto_saude/modules/abstract/abstract_search_card.dart';
import 'package:posto_saude/modules/paciente/controller/paciente_controller.dart';
import 'package:posto_saude/modules/paciente/model/paciente_model.dart';
import 'package:posto_saude/modules/paciente/pages/paciente_form_page.dart';
import 'package:provider/provider.dart';

class PacientesListView extends StatefulWidget {
  final PacienteControllers pacienteControllers = PacienteControllers();

  @override
  _PacientesListViewState createState() => _PacientesListViewState();
}

class _PacientesListViewState extends State<PacientesListView> {
  // final PacienteControllers pacienteControllers = PacienteControllers();
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    
    super.initState();
    // Inicialize a lista de pacientes no estado do widget
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Pacientes'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // SearchCard no topo
            SearchCard(
              searchController: searchController,
              onSearchPressed: () {
                // setState(() {
                context.watch<PacienteControllers>().pacienteFiltro =
                    widget.pacienteControllers.search(
                        context.read<AbstractManager<Paciente>>().entyties,
                        searchController.text);
                // });
              },
              labelText: 'Digite o termo de pesquisa',
              prefixIcon: Icons.search,
            ),
            SizedBox(height: 16),
            MyCard(
              title: 'Lista de Pacientes',
              children: [
                DataTable(
                  columns: [
                    DataColumn(label: Text('Nome')),
                    DataColumn(label: Text('Nome da Mãe')),
                    DataColumn(label: Text('CEP')),
                    DataColumn(label: Text('')),
                    DataColumn(label: Text('')),
                  ],
                  rows: context
                      .watch<AbstractManager<Paciente>>()
                      .entyties
                      .map((paciente) {
                    return DataRow(
                      cells: [
                        DataCell(Text(paciente.nome ?? 'N/A')),
                        DataCell(Text(paciente.nomeMae ?? 'N/A')),
                        DataCell(Text(paciente.cep ?? 'N/A')),
                        DataCell(
                          ElevatedButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PacienteFormPage(
                                        paciente: paciente,
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
                                    content: Text(
                                        'Tem certeza que deseja deletar o paciente?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(
                                              context); // Fechar o diálogo
                                        },
                                        child: Text('Cancelar'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          context
                                              .read<PacienteControllers>()
                                              .delete(context,
                                                  paciente); // Chamar o método de deletar
                                          Navigator.pop(
                                              context); // Fechar o diálogo
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
                // Navegar para a página de formulário de paciente
                Navigator.push<Paciente>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PacienteFormPage(),
                  ),
                );
              },
              child: Text('Cadastrar Paciente'),
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
