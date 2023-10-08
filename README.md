# DiceGame Smart Contract

The DiceGame smart contract is a simple Ethereum-based game where players can bet on the roll of a virtual six-sided die. If the player rolls a 6, they win the jackpot.

## Table of Contents

- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
  - [Configuring the Bet Amount](#configuring-the-bet-amount)
  - [Playing the Game](#playing-the-game)
  - [Checking the Jackpot](#checking-the-jackpot)
  - [Withdrawing Funds](#withdrawing-funds)
- [Contributing](#contributing)
- [License](#license)

## Getting Started

### Prerequisites

- Node.js
- npm
- Truffle (for development and deployment)
- An Ethereum wallet (e.g., MetaMask) connected to a local or testnet network

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/yourusername/dice-game.git
   cd dice-game
   ```

2. Install project dependencies:

   ```bash
   npm install
   ```

3. Deploy the smart contract to your preferred Ethereum network (e.g., local, Ropsten, etc.) using Truffle:

   ```bash
   truffle migrate
   ```

## Usage

### Configuring the Bet Amount

The default bet amount is set to 1 Ether. To change the bet amount, you can call the `setBetAmount` function as the contract owner:

```javascript
truffle console
const diceGame = await DiceGame.deployed()
await diceGame.setBetAmount(web3.utils.toWei('0.1', 'ether')) // Set the bet amount to 0.1 Ether
```

### Playing the Game

To play the game, send a transaction to the `rollDice` function with the bet amount:

```javascript
await diceGame.rollDice({ value: web3.utils.toWei('0.1', 'ether') }) // Replace with your desired bet amount
```

### Checking the Jackpot

You can check the current jackpot amount by calling the `jackpot` variable:

```javascript
const currentJackpot = await diceGame.jackpot()
console.log(`Current Jackpot: ${web3.utils.fromWei(currentJackpot)} Ether`)
```

### Withdrawing Funds

The contract owner can withdraw funds from the contract balance using the `withdrawFunds` function:

```javascript
await diceGame.withdrawFunds(web3.utils.toWei('1', 'ether')) // Withdraw 1 Ether
```

## Contributing

Contributions are welcome! If you would like to contribute to this project, please follow these steps:

1. Fork the repository.
2. Create a new branch for your feature: `git checkout -b feature-name`
3. Make your changes and commit them: `git commit -m 'Add some feature'`
4. Push your changes to your fork: `git push origin feature-name`
5. Create a pull request on the main repository's branch.

