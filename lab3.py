import numpy as np
import random

class ReversiGame:
    def __init__(self):
        self.board = np.full((8, 8), '.')
        self.board[3][3] = 'X'
        self.board[3][4] = 'O'
        self.board[4][3] = 'O'
        self.board[4][4] = 'X'

    def print_board(self):
        print(self.board)

    def is_valid_move(self, row, col, player):
        if self.board[row][col] != '.':
            return False
        opponent = 'X' if player == 'O' else 'O'
        directions = [(0, 1), (1, 0), (0, -1), (-1, 0), (1, 1), (-1, -1), (1, -1), (-1, 1)]
        for dr, dc in directions:
            r, c = row + dr, col + dc
            if 0 <= r < 8 and 0 <= c < 8 and self.board[r][c] == opponent:
                r, c = r + dr, c + dc
                while 0 <= r < 8 and 0 <= c < 8 and self.board[r][c] == opponent:
                    r, c = r + dr, c + dc
                if 0 <= r < 8 and 0 <= c < 8 and self.board[r][c] == player:
                    return True
        return False

    def make_move(self, row, col, player):
        if not self.is_valid_move(row, col, player):
            return False
        self.board[row][col] = player
        opponent = 'X' if player == 'O' else 'O'
        directions = [(0, 1), (1, 0), (0, -1), (-1, 0), (1, 1), (-1, -1), (1, -1), (-1, 1)]
        for dr, dc in directions:
            r, c = row + dr, col + dc
            if 0 <= r < 8 and 0 <= c < 8 and self.board[r][c] == opponent:
                r, c = r + dr, c + dc
                while 0 <= r < 8 and 0 <= c < 8 and self.board[r][c] == opponent:
                    r, c = r + dr, c + dc
                if 0 <= r < 8 and 0 <= c < 8 and self.board[r][c] == player:
                    r, c = row + dr, col + dc
                    while (r, c) != (row + dr, col + dc):
                        self.board[r][c] = player
                        r, c = r + dr, c + dc
        return True

    def count_pieces(self, player):
        return np.sum(self.board == player)

class ReinforcementLearningBot:
    def __init__(self, player):
        self.player = player
        self.probabilities = {}  # Словарь для хранения вероятностей ходов
        self.learning_rate = 0.1  # Скорость обучения

    def get_move(self, game):
        valid_moves = []
        for row in range(8):
            for col in range(8):
                if game.is_valid_move(row, col, self.player):
                    valid_moves.append((row, col))
        # Если это первый ход, выбираем случайный ход
        if not self.probabilities:
            return random.choice(valid_moves) if valid_moves else None
        # В противном случае выбираем ход с наибольшей вероятностью
        best_move = max(valid_moves, key=lambda move: self.probabilities.get(move, 0))
        return best_move

    def update_probabilities(self, move, reward):
        # Обновляем вероятность хода на основе полученного вознаграждения (победа или поражение)
        if move in self.probabilities:
            self.probabilities[move] += self.learning_rate * reward
        else:
            self.probabilities[move] = self.learning_rate * reward

def play_game_with_bots():
    game = ReversiGame()
    bot1 = ReinforcementLearningBot('X')
    bot2 = ReinforcementLearningBot('O')

    current_player = 'X'
    while True:
        print("Current player:", current_player)
        game.print_board()
        print("Number of X pieces:", game.count_pieces('X'))
        print("Number of O pieces:", game.count_pieces('O'))
        if current_player == 'X':
            move = bot1.get_move(game)
        else:
            move = bot2.get_move(game)
        if move:
            print("Selected move:", move)
            row, col = move
            game.make_move(row, col, current_player)
            current_player = 'X' if current_player == 'O' else 'O'
        else:
            current_player = 'X' if current_player == 'O' else 'O'
            if not any(game.is_valid_move(row, col, current_player) for row in range(8) for col in range(8)):
                # Определяем, кто выиграл
                winner = 'X' if game.count_pieces('X') > game.count_pieces('O') else 'O' if game.count_pieces('X') < game.count_pieces('O') else None
                # Обновляем вероятности ходов ботов на основе результата игры
                if winner:
                    bot1.update_probabilities(bot1.get_last_move(), 1 if bot1.player == winner else -1)
                    bot2.update_probabilities(bot2.get_last_move(), 1 if bot2.player == winner else -1)
                break

    game.print_board()
    print("Winner:", winner)

if __name__ == "__main__":
    play_game_with_bots()
