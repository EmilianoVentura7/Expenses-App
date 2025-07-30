class ExpenseModel {
  final int id;
  final String description;
  final double amount;
  final String type;
  final String date;
  final int categoryId;
  final CategoryModel category;

  ExpenseModel({
    required this.id,
    required this.description,
    required this.amount,
    required this.type,
    required this.date,
    required this.categoryId,
    required this.category,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'] ?? 0,
      description: json['description'] ?? '',
      amount: _toDouble(json['amount']),
      type: json['type'] ?? 'expense',
      date: json['date'] ?? '',
      categoryId: json['categoryId'] ?? 0,
      category:
          (json['Category'] != null && json['Category'] is Map<String, dynamic>)
              ? CategoryModel.fromJson(json['Category'])
              : CategoryModel(name: 'Sin categoría', color: '#808080'),
    );
  }
}

class CategoryModel {
  final String name;
  final String color;

  CategoryModel({required this.name, required this.color});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json['name'] ?? 'Sin categoría',
      color: json['color'] ?? '#808080',
    );
  }
}

double _toDouble(dynamic value) {
  if (value == null) return 0.0;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.tryParse(value) ?? 0.0;
  return 0.0;
}
