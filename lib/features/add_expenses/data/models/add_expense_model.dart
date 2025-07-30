import '../../domain/entities/add_expense_entity.dart';

class AddExpenseModel extends AddExpenseEntity {
  const AddExpenseModel({
    required super.description,
    required super.amount,
    required super.type,
    required super.categoryId,
    required super.date,
  });

  factory AddExpenseModel.fromJson(Map<String, dynamic> json) {
    return AddExpenseModel(
      description: json['description'] ?? '',
      amount: (json['amount'] ?? 0.0).toDouble(),
      type: json['type'] ?? 'expense',
      categoryId: json['categoryId'] ?? 1,
      date: json['date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'amount': amount,
      'type': type,
      'categoryId': categoryId,
      'date': date,
    };
  }
}
