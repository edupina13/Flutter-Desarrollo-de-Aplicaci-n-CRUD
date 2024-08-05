// auto_cubit.dart
import 'package:bloc/bloc.dart';
import '../../data/models/auto_model.dart';
import '../../data/repository/auto_repository.dart';
import 'auto_state.dart';

class AutoCubit extends Cubit<AutoState> {
  final AutoRepository autoRepository;

  AutoCubit({required this.autoRepository}) : super(AutoInitial());

  Future<void> createAuto(AutoModel auto) async {
    try {
      emit(AutoLoading());
      await autoRepository.createAuto(auto);
      final autos = await autoRepository.getAutos();
      emit(AutoSuccess(autos: autos));
    } catch (e) {
      emit(AutoError(message: e.toString()));
    }
  }

  Future<void> getAuto(int id) async {
    try {
      emit(AutoLoading());
      final autos = await autoRepository.getAutos();
      final auto = autos.firstWhere((element) => element.id == id);
      emit(AutoSuccess(autos: [auto]));
    } catch (e) {
      emit(AutoError(message: e.toString()));
    }
  }

  Future<void> updateAuto(AutoModel auto) async {
    try {
      emit(AutoLoading());
      await autoRepository.updateAuto(auto);
      final autos = await autoRepository.getAutos();
      emit(AutoSuccess(autos: autos));
    } catch (e) {
      emit(AutoError(message: e.toString()));
    }
  }

  Future<void> deleteAuto(int id) async {
    try {
      emit(AutoLoading());
      await autoRepository.deleteAuto(id);
      final autos = await autoRepository.getAutos();
      emit(AutoSuccess(autos: autos));
    } catch (e) {
      emit(AutoError(message: e.toString()));
    }
  }

  Future<void> fetchAllAutos() async {
    try {
      emit(AutoLoading());
      final autos = await autoRepository.getAutos();
      emit(AutoSuccess(autos: autos));
    } catch (e) {
      emit(AutoError(message: e.toString()));
    }
  }
}
