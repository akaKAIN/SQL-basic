revenue = int(input('Введите выручку фирмы: '))
costs = int(input('Введите издержки фирмы: '))
if revenue > costs:
    profit = revenue - costs
    print(f'Фирма получает прибыль в размере: {profit}')
    rent = profit / revenue
    print(f'Рентабельность выручки: {rent}')
elif revenue < costs:
    print('Фирма несёт убытки')
    employees = int(input('Введите количество сотрудников: '))
    em_profit = profit // employees
    print(f'Прибыль на одного сотрудника: {em_profit}')

