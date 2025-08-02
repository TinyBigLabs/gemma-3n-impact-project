import 'package:emergency_buddy/presentation/widgets/first_aid/blocs/first_aid_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageWeb extends StatefulWidget {
  const HomePageWeb({super.key, required this.location, required this.language});

  final String location;
  final String language;

  @override
  State<HomePageWeb> createState() => _HomePageWebState();
}

class _HomePageWebState extends State<HomePageWeb> {
  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 20),
          Text(
            "Hello!",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 20),
          Text(
            "This is the web version of the app.",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 20),
          Card(
            elevation: 4,
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Language: ${widget.language}",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Location: ${widget.location}",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            constraints: const BoxConstraints(maxHeight: 400),
            child: BlocBuilder<FirstAidCubit, FirstAidState>(
              builder: (context, state) {
                if (state is FirstAidLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is FirstAidAllCategoriesLoaded) {
                  return ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: _controller,
                    itemCount: state.categories.length,
                    separatorBuilder: (context, index) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final category = state.categories[index];
                      return ListTile(
                        title: Text(
                          category.title,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                          'ID: ${category.listingId}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          // TODO: Navigate to category detail
                          debugPrint('Tapped on category: ${category.title}');
                        },
                      );
                    },
                  );
                } else if (state is FirstAidError) {
                  return Center(child: Text('Error: ${state.errorMessage}'));
                } else {
                  return const Center(child: Text('No categories available.'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}