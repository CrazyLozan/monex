


class Expense{
  String friend;
  double amount;
  String currency;

  Expense(this.friend, this.amount, this.currency);

  Expense.fromJson(Map<String, dynamic> json){

    friend = json['friend'];
    amount = json['amount'].toDouble();
    currency = json['currency'];
  }

}

class ExpenseConvert{
  String friend;
  double amount;
  String currency;

  ExpenseConvert(this.friend, this.amount);

  ExpenseConvert.fromJson(Map<String, dynamic> json){

    friend = json['friend'];
    amount = json['amount'].toDouble();
    
  }

}