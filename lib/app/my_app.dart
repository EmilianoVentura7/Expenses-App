import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expenses_app/core/di/app_module.dart';
import 'package:expenses_app/core/router/domain/view/app_router.dart';
import 'package:expenses_app/features/login/presentation/cubit/login_cubit.dart';
import 'package:expenses_app/core/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) => LoginCubit(
                loginUseCase: AppModule.loginUseCase(),
                localStorageService: AppModule.localStorageService(),
              ),
        ),
      ],
      child: MaterialApp.router(
        title: 'Expenses App',
        theme: AppTheme.lightTheme,
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
