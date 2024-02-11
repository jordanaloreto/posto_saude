import 'package:posto_saude/modules/abstract/abstract_entity_model.dart';
import 'package:posto_saude/modules/abstract/abstract_manager.dart';
import 'package:posto_saude/modules/enfermeira/model/enfermeira_model.dart';
import 'package:posto_saude/modules/paciente/model/paciente_model.dart';

class EscutaInicial extends AbstractEntity {
  int idade;
  double peso;
  double altura;
  String problema;
  Paciente paciente;
  Enfermeira enfermeira;

  EscutaInicial({
    required int id,
    required this.idade,
    required this.peso,
    required this.altura,
    required this.problema,
    required this.paciente,
    required this.enfermeira, 
  });

   @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'documento': documento,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
