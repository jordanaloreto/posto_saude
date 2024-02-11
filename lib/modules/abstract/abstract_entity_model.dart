abstract class AbstractEntity {
  int? id;
  String? nome;
  String? documento;
  String? createdAt;
  String? updatedAt;

  AbstractEntity({
    this.id,
    this.nome,
    this.documento,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap();
}
