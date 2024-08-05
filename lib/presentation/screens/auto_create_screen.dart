import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/auto_cubit.dart';
import '../../../data/models/auto_model.dart';

class AutoCreateScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _tipoController = TextEditingController();
  final _capacidadController = TextEditingController();
  final _longitudController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crear Nuevo Auto')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nombreController,
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el nombre';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _tipoController,
                decoration: InputDecoration(labelText: 'Tipo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el tipo';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _capacidadController,
                decoration: InputDecoration(labelText: 'Capacidad'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa la capacidad';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _longitudController,
                decoration: InputDecoration(labelText: 'Longitud (m)'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa la longitud';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newAuto = AutoModel(
                      id: 0, // ID no se necesita al crear
                      nombre: _nombreController.text,
                      tipo: _tipoController.text,
                      capacidad: int.parse(_capacidadController.text),
                      longitud: double.parse(_longitudController.text),
                    );
                    context.read<AutoCubit>().createAuto(newAuto);
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Crear Auto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
