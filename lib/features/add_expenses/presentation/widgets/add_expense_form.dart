import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/category_model.dart';
import '../cubit/add_expense_cubit.dart';
import '../cubit/add_expense_state.dart';

class AddExpenseForm extends StatefulWidget {
  const AddExpenseForm({super.key});

  @override
  State<AddExpenseForm> createState() => _AddExpenseFormState();
}

class _AddExpenseFormState extends State<AddExpenseForm> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();

  String _selectedType = 'expense';
  CategoryModel? _selectedCategory;
  DateTime _selectedDate = DateTime.now();

  final List<CategoryModel> _categories = CategoryModel.getCategories();

  List<CategoryModel> get _filteredCategories {
    if (_selectedType == 'income') {
      // Solo mostrar la categoría 'Otros' para ingresos
      return _categories.where((c) => c.name.toLowerCase() == 'otros').toList();
    }
    // Mostrar todas para gastos
    return _categories;
  }

  @override
  void initState() {
    super.initState();
    _selectedCategory = _categories.first;
    _dateController.text = _formatDate(_selectedDate);
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = _formatDate(picked);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _selectedCategory != null) {
      final amount = double.tryParse(_amountController.text) ?? 0.0;

      context.read<AddExpenseCubit>().addExpense(
        description: _descriptionController.text.trim(),
        amount: amount,
        type: _selectedType,
        categoryId: _selectedCategory!.id,
        date: _dateController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Campo de descripción
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Descripción',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Por favor ingresa una descripción';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Campo de monto
            TextFormField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Monto',
                border: OutlineInputBorder(),
                prefixText: '\$',
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Por favor ingresa un monto';
                }
                if (double.tryParse(value) == null) {
                  return 'Por favor ingresa un monto válido';
                }
                if (double.parse(value) <= 0) {
                  return 'El monto debe ser mayor a 0';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Selector de tipo
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap:
                          () => setState(() {
                            _selectedType = 'income';
                            // Cambiar la categoría seleccionada a 'Otros' si es ingreso
                            final otros = _categories.firstWhere(
                              (c) => c.name.toLowerCase() == 'otros',
                            );
                            _selectedCategory = otros;
                          }),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color:
                              _selectedType == 'income'
                                  ? Colors.white
                                  : Colors.grey[200],
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4),
                            bottomLeft: Radius.circular(4),
                          ),
                        ),
                        child: const Text(
                          'Ingreso',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap:
                          () => setState(() {
                            _selectedType = 'expense';
                            // Si estaba en ingreso, poner la primera categoría por defecto
                            if (!_filteredCategories.contains(
                              _selectedCategory,
                            )) {
                              _selectedCategory = _categories.first;
                            }
                          }),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color:
                              _selectedType == 'expense'
                                  ? Colors.white
                                  : Colors.grey[200],
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(4),
                            bottomRight: Radius.circular(4),
                          ),
                        ),
                        child: const Text(
                          'Gasto',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Campo de fecha
            TextFormField(
              controller: _dateController,
              decoration: InputDecoration(
                labelText: 'Fecha',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: _selectDate,
                ),
              ),
              readOnly: true,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Por favor selecciona una fecha';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Selector de categoría
            DropdownButtonFormField<CategoryModel>(
              value: _selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Categoría',
                border: OutlineInputBorder(),
              ),
              items:
                  _filteredCategories.map((category) {
                    return DropdownMenuItem<CategoryModel>(
                      value: category,
                      child: Row(
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: Color(
                                int.parse(
                                  'FF${category.color.substring(1)}',
                                  radix: 16,
                                ),
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(category.name),
                        ],
                      ),
                    );
                  }).toList(),
              onChanged: (CategoryModel? value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'Por favor selecciona una categoría';
                }
                return null;
              },
            ),
            const SizedBox(height: 32),
            SizedBox(height: 24),
            // Botón de enviar
            BlocBuilder<AddExpenseCubit, AddExpenseState>(
              builder: (context, state) {
                final isIncome = _selectedType == 'income';
                final buttonText = isIncome ? 'Añadir ingreso' : 'Añadir gasto';
                return ElevatedButton(
                  onPressed: state is AddExpenseLoading ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  child:
                      state is AddExpenseLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(buttonText),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
