import 'package:posto_saude/modules/abstract/abstract_entity_model.dart';

class Enfermeira extends AbstractEntity {
  Enfermeira({
     int? id,
    String? nome,
    String? documento,
    String? createdAt,
    String? updatedAt,
  }) : super(
            id: id,
            nome: nome,
            documento: documento,
            createdAt: createdAt,
            updatedAt: updatedAt,
            );

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