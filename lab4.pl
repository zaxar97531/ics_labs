% Database of games
game('The Witcher 3: Wild Hunt', 'CD Projekt Red', 'RPG', 'action', 'PC', 'singleplayer', 300, 'Poland', 9.3).
game('The Legend of Zelda: Breath of the Wild', 'Nintendo', 'fantasy', 'action-adventure', 'Nintendo Switch', 'singleplayer', 150, 'Japan', 9.5).
game('Grand Theft Auto V', 'Rockstar North', 'open world', 'action-adventure', 'PC', 'singleplayer', 100, 'United Kingdom', 9.6).
game('The Last of Us Part II', 'Naughty Dog', 'survival horror', 'action-adventure', 'PlayStation', 'singleplayer', 40, 'USA', 9.0).
game('Red Dead Redemption 2', 'Rockstar Games', 'open world', 'action-adventure', 'PlayStation', 'singleplayer', 60, 'USA', 9.8).
game('Dark Souls III', 'FromSoftware', 'RPG', 'action', 'PC', 'singleplayer', 50, 'Japan', 8.6).
game('Super Mario Odyssey', 'Nintendo', 'adventure', 'platformer', 'Nintendo Switch', 'singleplayer', 20, 'Japan', 9.7).
game('Overwatch', 'Blizzard Entertainment', 'multiplayer', 'first-person shooter', 'PC', 'multiplayer', 30, 'USA', 7.6).
game('Portal 2', 'Valve Corporation', 'puzzle', 'first-person shooter', 'PC', 'singleplayer', 15, 'USA', 9.5).
game('Minecraft', 'Mojang Studios', 'adventure', 'sandbox', 'PC', 'singleplayer', 50, 'Sweden', 9.2).
game('League of Legends', 'Riot Games', 'multiplayer', 'MOBA', 'PC', 'online', 30, 'USA', 8.4).
game('The Elder Scrolls V: Skyrim', 'Bethesda Game Studios', 'RPG', 'action', 'PC', 'singleplayer', 80, 'USA', 9.3).

% Get platforms from user's input
get_platform(Platform, X) :- Platform = pc, X = ['PC'].
get_platform(Platform, X) :- Platform = playstation, X = ['PlayStation'].
get_platform(Platform, X) :- Platform = xbox, X = ['Xbox'].
get_platform(Platform, X) :- Platform = nintendo_switch, X = ['Nintendo Switch'].
get_platform(Platform, X) :- Platform = mobile, X = ['Mobile'].

% Get genres from user's input
get_genre(Genre, X) :- Genre = action, X = ['action'].
get_genre(Genre, X) :- Genre = adventure, X = ['action-adventure'].
get_genre(Genre, X) :- Genre = rpg, X = ['RPG'].
get_genre(Genre, X) :- Genre = platformer, X = ['platformer'].
get_genre(Genre, X) :- Genre = shooter, X = ['first-person shooter'].
get_genre(Genre, X) :- Genre = puzzle, X = ['puzzle'].
get_genre(Genre, X) :- Genre = sandbox, X = ['sandbox'].
get_genre(Genre, X) :- Genre = moba, X = ['MOBA'].

% Get modes from user's input
get_mode(Mode, X) :- Mode = singleplayer, X = ['singleplayer'].
get_mode(Mode, X) :- Mode = multiplayer, X = ['multiplayer'].
get_mode(Mode, X) :- Mode = online, X = ['online'].

% Check if X is an element of List
elem(X, [X|_]).
elem(X, [_|Tail]) :- elem(X, Tail).

% Check whether lists have a common element
elems(X, [Y|_]) :- elem(Y, X).
elems(X, [_|Tail]) :- elems(X, Tail).

% List games that match the criteria
list_game(Developer, Genres, Platforms, Modes, MaxDuration, Acc, L) :-
    game(Name, Dev, Genre, _, Platform, Mode, Duration, _, _),
    elem(Dev, Developer),
    elem(Genre, Genres),
    elem(Platform, Platforms),
    elem(Mode, Modes),
    Duration =< MaxDuration,
    \+ elem(Name, Acc), !,
    list_game(Developer, Genres, Platforms, Modes, MaxDuration, [Name|Acc], L).

list_game(_, _, _, _, _, L, L).

% Suggest game to a user
suggest_game(L) :- 
    write('Welcome to the Game Recommendation System!'), nl,
    write('Please answer the following questions to get a game recommendation.'), nl,
    write('Choose your platform: (pc, playstation, xbox, nintendo_switch, mobile)'), nl,
    read(Platform),
    write('Choose the genre you are interested in: (action, adventure, rpg, platformer, shooter, puzzle, sandbox, moba)'), nl,
    read(Genre),
    write('Do you prefer singleplayer, multiplayer, or online games?'), nl,
    read(Mode),
    write('What is the maximum duration of the game in hours?'), nl,
    read(Duration),
    list_game(_, [Genre], [Platform], [Mode], Duration, [], L).
