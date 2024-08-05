import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/auto_cubit.dart';
import '../../data/models/auto_model.dart';

class AutoUpdateScreen extends StatelessWidget {
  final AutoModel auto;
  AutoUpdateScreen({required this.auto});

  @override
  Widget build(BuildContext context) {
    final _nombreController = TextEditingController(text: auto.nombre);
    final _tipoController = TextEditingController(text: auto.tipo);
    final _capacidadController = TextEditingController(text: auto.capacidad.toString());
    final _longitudController = TextEditingController(text: auto.longitud.toString());

    return Scaffold(
      appBar: AppBar(title: Text('Actualizar Auto')),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nombreController,
                decoration: InputDecoration(labelText: 'Nombre'),
              ),
              TextFormField(
                controller: _tipoController,
                decoration: InputDecoration(labelText: 'Tipo'),
              ),
              TextFormField(
                controller: _capacidadController,
                decoration: InputDecoration(labelText: 'Capacidad'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _longitudController,
                decoration: InputDecoration(labelText: 'Longitud'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              ElevatedButton(
                onPressed: () {
                  AutoModel updatedAuto = AutoModel(
                    id: auto.id,
                    nombre: _nombreController.text,
                    tipo: _tipoController.text,
                    capacidad: int.parse(_capacidadController.text),
                    longitud: double.parse(_longitudController.text),
                  );
                  context.read<AutoCubit>().updateAuto(updatedAuto);
                  Navigator.of(context).pop();
                },
                child: Text('Guardar Cambios'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
