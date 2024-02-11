import 'package:flutter/material.dart';
import 'package:posto_saude/modules/paciente/pages/pacientes_list_view.dart';

class SearchCard extends StatelessWidget {
  final TextEditingController searchController;
  final VoidCallback onSearchPressed;
  final String labelText;
  final IconData prefixIcon;

  SearchCard({
    required this.searchController,
    required this.onSearchPressed,
    required this.labelText,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return MyCard(
      title: 'Pesquisar',
      children: [
        TextField(
          controller: searchController,
          decoration: InputDecoration(
            labelText: labelText,
            prefixIcon: Icon(prefixIcon),
          ),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: onSearchPressed,
          child: Text('Pesquisar'),
        ),
      ],
    );
  }
}
