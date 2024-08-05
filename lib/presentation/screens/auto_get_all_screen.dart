import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/auto_cubit.dart';
import '../cubit/auto_state.dart';
import '../../../data/models/auto_model.dart';
import 'auto_update_screen.dart';
import 'auto_create_screen.dart';

class AutoGetAllScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Autos'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => context.read<AutoCubit>().fetchAllAutos(),
          )
        ],
      ),
      body: BlocBuilder<AutoCubit, AutoState>(
        builder: (context, state) {
          if (state is AutoLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is AutoSuccess) {
            final autos = state.autos;
            return ListView.builder(
              itemCount: autos.length,
              itemBuilder: (context, index) {
                final auto = autos[index];
                return ListTile(
                  title: Text('${auto.nombre} (${auto.tipo})'),
                  subtitle: Text(
                    'Capacidad: ${auto.capacidad} personas\nLongitud: ${auto.longitud} m',
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => AutoUpdateScreen(auto: auto)),
                    );
                  },
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                    onPressed: () => context.read<AutoCubit>().deleteAuto(auto.id),
                  ),
                );
              },
            );
          } else if (state is AutoError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return Container();  // Mostrar un contenedor vacío si el estado no es ninguno de los anteriores.
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => AutoCreateScreen()),
        ),
      ),
    );
  }
}
