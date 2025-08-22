# STX Treasure Chest
# 🌟 STX Treasure Chest

A **time-locked jackpot chest** built on Stacks.  
Deposit your STX into a magical treasure chest. The chest remains sealed until the chosen **unlock block**, then bursts open, releasing all rewards to the lucky beneficiary! 🎁


## ✨ Features
- 🗝️ **Create Chests** with a future unlock block.  
- 💰 **Deposit Anytime** — anyone can add to the chest’s balance.  
- 🔓 **Open Chest** only after the block height is reached.  
- 🎉 **Beneficiary Wins It All**.  


## 🚀 Example Flow

### 1. Create Chest
```clarity
(contract-call? .treasure-chest create-chest 'ST123... u1500)
 
