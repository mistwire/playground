// game/game.go
package game

type Game struct {
    Word     string
    Attempts []string
    MaxTries int
}

func NewGame() *Game {
    return &Game{
        Word:     getRandomWord(),
        MaxTries: 6,
        Attempts: make([]string, 0),
    }
}

func (g *Game) MakeGuess(guess string) []GuessResult {
    // Implementation for checking the guess
    // Return array of letter results (correct, wrong position, incorrect)
}

