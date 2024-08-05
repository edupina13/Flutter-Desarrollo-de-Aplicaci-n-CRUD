
class AutoModel {
  final int id;
  final String nombre;
  final String tipo;
  final int capacidad;
  final double longitud;

  AutoModel({
    required this.id,
    required this.nombre,
    required this.tipo,
    required this.capacidad,
    required this.longitud,
  });

  factory AutoModel.fromJson(Map<String, dynamic> json) {
    return AutoModel(
      id: json['id'],
      nombre: json['nombre'],
      tipo: json['tipo'],
      capacidad: json['capacidad'],
      longitud: (json['longitud'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'tipo': tipo,
      'capacidad': capacidad,
      'longitud': longitud,
    };
  }
}
