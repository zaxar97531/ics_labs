/** ИГРЫ */
game('The Witcher 3: Wild Hunt', 'CD Projekt Red', 2015, 'action', 'RPG', 300, 'Poland', 'Geralt of Rivia', 9.3, 252).
game('The Legend of Zelda: Breath of the Wild', 'Nintendo', 2017, 'action-adventure', 'fantasy', 150, 'Japan', 'Link', 9.5, 153).
game('Grand Theft Auto V', 'Rockstar North', 2013, 'action-adventure', 'open world', 100, 'United Kingdom', 'Various', 9.6, 730).
game('The Last of Us Part II', 'Naughty Dog', 2020, 'action-adventure', 'survival horror', 40, 'USA', 'Ellie', 9.0, 102).
game('Red Dead Redemption 2', 'Rockstar Games', 2018, 'action-adventure', 'open world', 60, 'USA', 'Arthur Morgan', 9.8, 427).
game('Dark Souls III', 'FromSoftware', 2016, 'action', 'RPG', 50, 'Japan', 'Various', 8.6, 104).
game('Super Mario Odyssey', 'Nintendo', 2017, 'platformer', 'adventure', 20, 'Japan', 'Mario', 9.7, 351).
game('Overwatch', 'Blizzard Entertainment', 2016, 'first-person shooter', 'multiplayer', 30, 'USA', 'Various', 7.6, 115).
game('Portal 2', 'Valve Corporation', 2011, 'puzzle', 'first-person shooter', 15, 'USA', 'Chell', 9.5, 224).
game('Minecraft', 'Mojang Studios', 2011, 'sandbox', 'adventure', 50, 'Sweden', 'Steve', 9.2, 743).
game('League of Legends', 'Riot Games', 2009, 'MOBA', 'multiplayer', 'online', 'USA', 'Various', 8.4, 2112).
game('The Elder Scrolls V: Skyrim', 'Bethesda Game Studios', 2011, 'action', 'RPG', 'open world', 80, 'USA', 'Various', 9.3, 487).

/** РАЗРАБОТЧИКИ */
developer('CD Projekt Red').
developer('Nintendo').
developer('Rockstar North').
developer('Naughty Dog').
developer('Rockstar Games').
developer('FromSoftware').
developer('Blizzard Entertainment').
developer('Valve Corporation').
developer('Mojang Studios').
developer('Riot Games').
developer('Bethesda Game Studios').

/** ЖАНРЫ */
genre('action').
genre('action-adventure').
genre('RPG').
genre('platformer').
genre('first-person shooter').
genre('puzzle').
genre('sandbox').
genre('MOBA').

/** ПЛАТФОРМЫ */
platform('PC').
platform('PlayStation').
platform('Xbox').
platform('Nintendo Switch').
platform('Mobile').

/** ВСПОМОГАТЕЛЬНЫЕ ФУНКЦИИ */
game_with_developer(Name) :- game(Name, Developer, _, _, _, _, _, _, _, _), developer(Developer).
game_with_genre(Name) :- game(Name, _, _, Genre, _, _, _, _, _, _), genre(Genre).
game_with_platform(Name) :- game(Name, _, _, _, _, _, _, _, _, _), platform(Name).

/** СИСТЕМА РЕКОМЕНДАЦИЙ ДЛЯ ИГР */
recommendation(X, Y, O) :-
    (X == 'PC' ; X == 'PlayStation' ; X == 'Xbox' ; X == 'Nintendo Switch' ; X == 'Mobile'),
    (Y == 'action' ; Y == 'adventure' ; Y == 'RPG' ; Y == 'platformer' ; Y == 'shooter' ; Y == 'puzzle' ; Y == 'sandbox' ; Y == 'MOBA'),
    (O == 'singleplayer' ; O == 'multiplayer' ; O == 'online'),
    game(Name, _, _, Y, _, Duration, _, _, _, _),
    platform(Name, X),
    ((Duration < 50, O == 'singleplayer') ; (Duration < 30, O == 'multiplayer') ; (O == 'online')),
    !,
    write(Name).

/** ОСНОВНАЯ ЛОГИКА ПРОГРАММЫ */
start :-
    write('Экспертная система - Рекомендатель игр'), nl,
    write('Ответьте на следующие вопросы для получения рекомендации игр.'), nl,
    write('На какой платформе вы хотели бы играть? '), read(Platform), nl,
    write('Какой жанр игр вас интересует? '), read(Genre), nl,
    write('Вы предпочитаете одиночные игры, многопользовательские или онлайн? '), read(Mode), nl,
    write('Рекомендуемые игры: '), nl,
    recommendation(Platform, Genre, Mode), nl.

/** СИСТЕМА РЕКОМЕНДАЦИЙ ДЛЯ ФИЛЬМОВ */
recommendation_year(Y, Ans1, Ans2, Ans3, Ans4, Ans5, Ans6) :-
    film(Y, Ans1, Ans2, Ans3, Ans4, Ans5, Ans6).

film_with_genre(Y, Gendre) :-
    film(Y, _, Gendre, _, _, _, _).

/** ВСПОМОГАТЕЛЬНЫЕ ФУНКЦИИ ДЛЯ ФИЛЬМОВ И ИГР */
game_with_developer(Name) :- game(Name, Developer, _, _, _, _, _, _, _, _), developer(Developer).
game_with_genre(Name) :- game(Name, _, _, Genre, _, _, _, _, _, _), genre(Genre).
game_with_platform(Name) :- game(Name, _, _, _, _, _, _, _, _, _), platform(Name).

recommendation_platform(Platform, Name) :-
    game(Name, _, _, _, _, _, _, _, _, _),
    platform(Name, Platform).

recommendation_genre(Genre, Name) :-
    game(Name, _, _, Genre, _, _, _, _, _, _).

recommendation_mode(Mode, Name) :-
    game(Name, _, _, _, _, Duration, _, _, _, _),
    ((Duration < 50, Mode == 'singleplayer') ; (Duration < 30, Mode == 'multiplayer') ; (Mode == 'online')).

/** ОСНОВНАЯ ЛОГИКА ПРОГРАММЫ */
start :-
    write('Экспертная система - Рекомендатель фильмов и игр'), nl,
    write('Выберите, что вы хотели бы получить рекомендации:'), nl,
    write('1. Фильмы'), nl,
    write('2. Игры'), nl,
    read(Choice), nl,
    (
        Choice == 1 ->
            write('Ответьте на следующие вопросы для получения рекомендации фильма.'), nl,
            write('Предпочитаете ли вы старые фильмы? '), read(A1), nl,
            (   A1 == 'no' ->
                write('Предпочитаете ли вы новые фильмы? '), read(A2), nl,
                (   A2 == 'no' -> Ans1 = 'decent' ; Ans1 = 'newer' )
            ;   Ans1 = 'older'
            ),
            write('Какой жанр фильма вас интересует? '), read(Ans2), nl,
            (
                Ans2 == 'horror' ->
                write('Чего вы боитесь? '), read(Ans5), nl
                ; Ans2 == 'adventure' ->
                write('Какого типа приключенческие фильмы вас интересуют? '), read(Ans5), nl
                ; Ans5 = 'others'
            ),
            write('Сколько времени у вас есть? '), read(C1), nl,
            (
                C1 == 'many' ->
                write('У вас действительно много времени? '), read(C2), nl,
                (   C2 == 'no' -> Ans3 = 'long' ; Ans3 = 'verylong' )
                ; Ans3 = 'short'
            ),
            write('Понравилось ли вам польское кино? '), read(Ans4), nl,
            write('Главный герой - мужчина? '), read(E1), nl,
            (   E1 == 'yes' -> Ans6 = 'm' ; (E1 == 'no' -> Ans6 = 'w' ; Ans6 = '') ),
            recommendation_year(Y, Ans1, Ans2, Ans3, Ans4, Ans5, Ans6),
            write('Рекомендуемый жанр фильма: '), write(Y), nl
        ;   Choice == 2 ->
            write('Ответьте на следующие вопросы для получения рекомендации игр.'), nl,
            write('На какой платформе вы хотели бы играть? '), read(Platform), nl,
            write('Какой жанр игр вас интересует? '), read(Genre), nl,
            write('Вы предпочитаете одиночные игры, многопользовательские или онлайн? '), read(Mode), nl,
            write('Рекомендуемые игры: '), nl,
            recommendation_platform(Platform, Name),
            recommendation_genre(Genre, Name),
            recommendation_mode(Mode, Name),
            !,
            write(Name), nl
    ).
