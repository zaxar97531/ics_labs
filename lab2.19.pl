% Предикат, который находит максимальный элемент списка.
max_list([Head | Tail], Max) :-
    % Инициализируем поиск максимального элемента,
    % начиная с первого элемента списка.
    max_list_helper(Tail, Head, Max), !.

% Вспомогательный предикат, который рекурсивно проходит по списку,
% сравнивая текущий максимальный элемент с каждым элементом списка.
max_list_helper([], Max, Max).
max_list_helper([Head | Tail], CurrentMax, Max) :-
    % Если текущий элемент больше текущего максимума,
    % обновляем текущий максимум.
    Head > CurrentMax,
    max_list_helper(Tail, Head, Max).
max_list_helper([Head | Tail], CurrentMax, Max) :-
    % Если текущий элемент не больше текущего максимума,
    % продолжаем поиск с текущим максимумом.
    Head =< CurrentMax,
    max_list_helper(Tail, CurrentMax, Max).
