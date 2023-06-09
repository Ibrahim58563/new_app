import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/repo/home_repo_implementation.dart';
import 'package:news_app/core/utils/service_locator.dart';
import 'package:news_app/features/presentation/manager/auth/login/login_cubit.dart';
import 'package:news_app/features/presentation/manager/auth/signup/signup_cubit.dart';
import 'package:news_app/features/presentation/manager/every_news/every_news_cubit.dart';
import 'package:news_app/features/presentation/manager/top_headlines/top_headlines_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/utils/app_routes.dart';
import 'firebase_options.dart';

// bdcd432edce64b73b050a35f7def53cf
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              TopHeadlinesCubit(getIt.get<HomeRepoImplementation>())
                ..fetchBreakingNews(),
        ),
        BlocProvider(
          create: (context) =>
              EveryNewCubit(getIt.get<HomeRepoImplementation>())
                ..fetchEveryNews(),
        ),
        BlocProvider(create: (context)=>signupCubit()),
        BlocProvider(create: (context)=>LoginCubit())
      ],
      child: MaterialApp.router(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
