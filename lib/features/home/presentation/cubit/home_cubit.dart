import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/home_use_case.dart';
import '../../domain/entities/home_entity.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeUseCase homeUseCase;
  HomeCubit(this.homeUseCase) : super(HomeInitial());

  Future<void> loadHomeData() async {
    emit(HomeLoading());
    try {
      final homeData = await homeUseCase();
      emit(HomeSuccess(homeData));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
