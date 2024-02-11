import 'package:posto_saude/modules/abstract/abstract_entity_model.dart';

class Paciente extends AbstractEntity {
  String? nomeMae;
  String? cep;
  Paciente({
    super.createdAt,
    super.nome,
    super.documento,
    super.id,
    super.updatedAt,
    this.nomeMae,
    this.cep,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'documento': documento,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'nome_mae': nomeMae,
      'CEP': cep,
    };
  }
}
