import 'package:posto_saude/modules/abstract/abstract_entity_model.dart';
import 'package:posto_saude/modules/abstract/abstract_manager.dart';
import 'package:posto_saude/modules/enfermeira/model/enfermeira_model.dart';
import 'package:posto_saude/modules/escutaInicial/model/escutaInicial_model.dart';
import 'package:posto_saude/modules/medico/model/medico_model.dart';
import 'package:posto_saude/modules/paciente/model/paciente_model.dart';

class Prontuario extends AbstractEntity {
  String diagnostico;
  String tratamento;
  EscutaInicial escutaInicial;
  Medico medico;

  Prontuario({
    required super.id,
    required this.escutaInicial,
    required this.diagnostico,
    required this.tratamento,
    required this.medico,
  });

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}
