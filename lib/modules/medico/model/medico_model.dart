import 'package:posto_saude/modules/abstract/abstract_entity_model.dart';

class Medico extends AbstractEntity {
  Medico({
    super.createdAt,
    super.nome,
    super.documento,
    super.id,
    super.updatedAt,
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
