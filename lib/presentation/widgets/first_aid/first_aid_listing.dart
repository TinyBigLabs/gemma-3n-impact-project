import 'package:emergency_buddy/presentation/widgets/first_aid/blocs/first_aid_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class FirstAidListing extends StatelessWidget {

  const FirstAidListing({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      constraints: const BoxConstraints(maxHeight: 400),
      child: BlocBuilder<FirstAidCubit, FirstAidState>(
        builder: (context, state) {
          if (state is FirstAidLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FirstAidAllCategoriesLoaded) {
            return ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
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
    );
  }
}
