import '../entities/home_entity.dart';
import '../repositories/home_repository.dart';

class HomeUseCase {
  final HomeRepository repository;
  HomeUseCase(this.repository);

  Future<HomeEntity> call() async {
    final model = await repository.getHomeData();

    return HomeEntity(
      userProfile: UserProfileEntity(
        id: model.userProfile.id,
        name: model.userProfile.name,
        email: model.userProfile.email,
      ),
      expenseSummary: ExpenseSummaryEntity(
        totalIncome: model.expenseSummary.totalIncome,
        totalExpenses: model.expenseSummary.totalExpenses,
        balance: model.expenseSummary.balance,
        expensesByCategory:
            model.expenseSummary.expensesByCategory
                .map(
                  (category) => ExpenseCategoryEntity(
                    name: category.name,
                    color: category.color,
                    total: category.total,
                    count: category.count,
                  ),
                )
                .toList(),
      ),
      recentExpenses:
          model.recentExpenses
              .map(
                (expense) => ExpenseEntity(
                  id: expense.id,
                  description: expense.description,
                  amount: expense.amount,
                  type: expense.type,
                  date: expense.date,
                  categoryId: expense.categoryId,
                  category: CategoryEntity(
                    name: expense.category.name,
                    color: expense.category.color,
                  ),
                ),
              )
              .toList(),
    );
  }
}
