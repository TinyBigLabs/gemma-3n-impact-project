import 'package:emergency_buddy/domain/repositories/first_aid_repository.dart';
import 'package:emergency_buddy/domain/usecases/get_first_aid_home_screen_listing_usecase.dart';
import 'package:emergency_buddy/presentation/widgets/first_aid/blocs/first_aid_cubit.dart';
import 'package:flutter/material.dart';
import 'package:emergency_buddy/presentation/pages/landing_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize any necessary services here, like SharedPreferences or others.
  await di.init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => di.sl<FirstAidRepository>(),
        child: BlocProvider(
        create: (context) => di.sl<FirstAidCubit>(),
    child:MaterialApp(
        title: 'Emergency Buddy',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: const LandingPage(title: 'Emergency Buddy'),
    ),
        ),
    );
  }
}
