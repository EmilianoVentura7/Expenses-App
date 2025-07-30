import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../add_expenses/data/models/category_model.dart';
import '../cubit/update_expense_cubit.dart';
import '../cubit/update_expense_state.dart';

class UpdateExpenseForm extends StatefulWidget {
  final int expenseId;
  final Map<String, dynamic> initialExpense;
  final UpdateExpenseCubit cubit;

  const UpdateExpenseForm({
    super.key,
    required this.expenseId,
    required this.initialExpense,
    required this.cubit,
  });

  @override
  State<UpdateExpenseForm> createState() => _UpdateExpenseFormState();
}

class _UpdateExpenseFormState extends State<UpdateExpenseForm> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();

  String _selectedType = 'expense';
  CategoryModel? _selectedCategory;
  DateTime _selectedDate = DateTime.now();

  final List<CategoryModel> _categories = CategoryModel.getCategories();

  @override
  void initState() {
    super.initState();
    _initializeForm();
  }

  void _initializeForm() {
    // Prellenar el formulario con los datos del gasto
    _descriptionController.text = widget.initialExpense['description'] ?? '';
    _amountController.text =
        (widget.initialExpense['amount'] ?? 0.0).toString();
    _selectedType = widget.initialExpense['type'] ?? 'expense';

    // Buscar la categoría correspondiente
    final categoryId = widget.initialExpense['categoryId'] ?? 1;
    _selectedCategory = _categories.firstWhere(
      (category) => category.id == categoryId,
      orElse: () => _categories.first,
    );

    // Configurar la fecha
    final dateString = widget.initialExpense['date'] ?? '';
    if (dateString.isNotEmpty) {
      try {
        final parts = dateString.split('-');
        if (parts.length == 3) {
          _selectedDate = DateTime(
            int.parse(parts[0]),
            int.parse(parts[1]),
            int.parse(parts[2]),
          );
        }
      } catch (e) {
        _selectedDate = DateTime.now();
      }
    }

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

      widget.cubit.updateExpense(
        id: widget.expenseId,
        description: _descriptionController.text.trim(),
        amount: amount,
        type: _selectedType,
        categoryId: _selectedCategory!.id,
        date: _dateController.text,
      );
    }
  }

  void _showDeleteConfirmation() {
    print(
      'Mostrando confirmación de eliminación para gasto ID: ${widget.expenseId}',
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Eliminación'),
          content: const Text(
            '¿Estás seguro de que quieres eliminar este gasto? Esta acción no se puede deshacer.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                print(
                  'Usuario confirmó eliminación del gasto ID: ${widget.expenseId}',
                );
                Navigator.of(context).pop();
                widget.cubit.deleteExpense(widget.expenseId);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
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
                      onTap: () => setState(() => _selectedType = 'income'),
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
                      onTap: () => setState(() => _selectedType = 'expense'),
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
                  _categories.map((category) {
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
            // Botones de acción
            BlocBuilder<UpdateExpenseCubit, UpdateExpenseState>(
              bloc: widget.cubit,
              builder: (context, state) {
                final isLoading =
                    state is UpdateExpenseLoading ||
                    state is DeleteExpenseLoading;
                final isIncome = _selectedType == 'income';
                final updateText =
                    isIncome ? 'Actualizar ingreso' : 'Actualizar gasto';
                final deleteText =
                    isIncome ? 'Eliminar ingreso' : 'Eliminar gasto';

                return Column(
                  children: [
                    // Botón de actualizar
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _submitForm,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                        ),
                        child:
                            state is UpdateExpenseLoading
                                ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                                : Text(updateText),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Botón de eliminar
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _showDeleteConfirmation,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        child:
                            state is DeleteExpenseLoading
                                ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                                : Text(deleteText),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
