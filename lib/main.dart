import 'package:flutter/material.dart';
import 'package:posto_saude/modules/abstract/abstract_manager.dart';
import 'package:posto_saude/modules/enfermeira/model/enfermeira_model.dart';
import 'package:posto_saude/modules/enfermeira/pages/enfermeira_form_page.dart';
import 'package:posto_saude/modules/enfermeira/pages/enfermeira_list_view.dart';
import 'package:posto_saude/modules/escutaInicial/controller/escutaInicial_controller.dart';
import 'package:posto_saude/modules/escutaInicial/model/escutaInicial_model.dart';
import 'package:posto_saude/modules/escutaInicial/pages/escutaInicial_form_page.dart';
import 'package:posto_saude/modules/escutaInicial/pages/escutaInicial_list_view.dart';
import 'package:posto_saude/modules/medico/model/medico_model.dart';
import 'package:posto_saude/modules/medico/pages/medico_form_page.dart';
import 'package:posto_saude/modules/medico/pages/medico_list_view.dart';
import 'package:posto_saude/modules/paciente/controller/paciente_controller.dart';
import 'package:posto_saude/modules/paciente/model/paciente_lista_manager.dart';
import 'package:posto_saude/modules/paciente/model/paciente_model.dart';
import 'package:posto_saude/modules/paciente/pages/pacientes_list_view.dart';
import 'package:posto_saude/modules/prontuario/model/prontuario_model.dart';
import 'package:posto_saude/modules/prontuario/pages/prontuario_list_view.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (conext) => AbstractManager<Paciente>(),
          ),
          ChangeNotifierProvider(
            create: (conext) => AbstractManager<Enfermeira>(),
          ),
          ChangeNotifierProvider(
            create: (conext) => AbstractManager<Medico>(),
          ),
          ChangeNotifierProvider(
            create: (conext) => AbstractManager<EscutaInicial>(),
          ),
          ChangeNotifierProvider(
            create: (conext) => AbstractManager<Prontuario>(),
          ),
          ChangeNotifierProvider(
            create: (conext) => EscutaInicialControllers(),
          ),
        ],
        child: MaterialApp(
          home: TelaPrincipal(),
          debugShowCheckedModeBanner:
              false, // Configuração para remover a faixa de banner
        ),
      ),
    );

class TelaPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha Aplicação'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Enfermeira'),
              onTap: () {
                Navigator.pop(context); 
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EnfermeiraListView()),
                );
              },
            ),
            ListTile(
              title: Text('Médico'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MedicoListView()),
                );
              },
            ),
            ListTile(
              title: Text('Paciente'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PacientesListView(
                          )),
                );
              },
            ),
            ListTile(
              title: Text('Escuta Inicial'),
              onTap: () {
                Navigator.pop(context); 
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EscutaInicialListView(
                          )),
                );
              },
            ),
            ListTile(
              title: Text('Prontuário'),
              onTap: () {
                Navigator.pop(context); 
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProntuarioListView(
                          )),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Selecione uma opção no menu para começar.'),
      ),
    );
  }
}

//SE EU COLOCAR ESSA PARTE DO CÓDIGO EU NÃO PRECISO 
//IMPORTAR A CLASSE DE ENFERMEIRA, MAS SE EU NÃO IMPORTAR ELA, 
//NÃO CHAMA A MINHA TELA DE CADASTRO 
// class EnfermeiraFormPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cadastro de Enfermeira'),
//       ),
//       body: Center(
//         child: Text('Tela de Cadastro de Enfermeira'),
//       ),
//     );
//   }
// }

