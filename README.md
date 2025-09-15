# 💬 ChainMessage – The Eternal Blockchain Message Board

> "Words fade on paper, vanish on screens… but on the blockchain, they last forever." ⛓️📝  

**ChainMessage** is a simple but powerful Clarity contract that allows **every wallet address to leave one permanent message** on the blockchain.  
Once written, the message **cannot be changed or deleted**. It becomes part of the chain’s eternal history.  

It’s a social contract for permanence — short, unique, and unforgettable.  

---

## ✨ Features
- 📝 **One Message Per Wallet** – every user gets one shot to leave their mark.  
- ⏳ **Immutable** – once written, it can’t be changed. Your message lives forever.  
- 🌐 **Public & Transparent** – anyone can view messages from any address.  
- 💡 **Lightweight** – less than 40 lines of code, yet infinitely meaningful.  

---

## 🚀 How It Works

### 1. Write Your Message

```clarity
(contract-call? .chainmessage write "Hello, future! 🌍")
```

➡️ Saves your message forever, tied to your wallet and the block it was written in.

### 2. View Your Message

```clarity
(contract-call? .chainmessage get-message tx-sender)
```

➡️ Shows the message you wrote and the block number.

### 3. Try Again? Nope.

```clarity
(contract-call? .chainmessage write "Oops, I changed my mind")
```

➡️ Returns error `u100` (you already wrote your one message).

---

## 🎨 Why ChainMessage?

* 🌟 **Unique** – not about tokens, lotteries, or transfers, but about human permanence.
* ✨ **Emotional** – your message could be love, poetry, a declaration, or a warning to the future.
* 🔒 **Immutable** – unlike social media, it cannot be censored or erased.
* 📜 **Cultural Value** – one day, historians may read these messages as a time capsule of our era.

---


## 🌌 Vision

One day, ChainMessage could evolve into:

* 🏛️ **A blockchain monument** – where future generations read the words of today.
* ❤️ **A global love wall** – people leaving eternal love notes on-chain.
* ⏳ **A digital time capsule** – forever preserving voices that would otherwise vanish.

Your wallet gets one message.
What will **you** choose to say forever? 📝

## 📜 License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details
## ❤️ Acknowledgements 

*Made with ❤️ for the blockchain community.*
