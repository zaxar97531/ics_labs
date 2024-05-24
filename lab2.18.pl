% Удалить два последних элемента из списка.
remove_last_two(List, Result) :-
    % Сначала проверяем, что длина списка должна быть больше или равна 2,
    % иначе операция удаления двух последних элементов не имеет смысла.
    length(List, Length),
    Length >= 2,
    % Затем вызываем вспомогательный предикат с начальным пустым аккамулятором.
    remove_last_two_helper(List, [], Result).

% Вспомогательный предикат, который удаляет два последних элемента из списка.
remove_last_two_helper([_, _], Accumulator, Result) :-
    % Если в списке остаются только два элемента, возвращаем накопленный результат.
    reverse(Accumulator, Result).
remove_last_two_helper([Head | Tail], Accumulator, Result) :-
    % Рекурсивно обрабатываем список, добавляя текущий элемент в аккумулятор.
    remove_last_two_helper(Tail, [Head | Accumulator], Result).
