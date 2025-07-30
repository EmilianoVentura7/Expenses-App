import '../../domain/entities/update_expense_entity.dart';

class UpdateExpenseModel extends UpdateExpenseEntity {
  const UpdateExpenseModel({
    required super.id,
    required super.description,
    required super.amount,
    required super.type,
    required super.categoryId,
    required super.date,
  });

  factory UpdateExpenseModel.fromJson(Map<String, dynamic> json) {
    return UpdateExpenseModel(
      id: json['id'] ?? 0,
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
