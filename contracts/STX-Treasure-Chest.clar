;; contracts/treasure-chest.clar
;; STX Treasure Chest - a time-locked jackpot vault

(define-data-var chest-id uint u0)

(define-map chests
  { id: uint }
  {
    beneficiary: principal,
    unlock-block: uint,
    balance: uint,
    opened: bool
  }
)

(define-constant ERR-OPENED u100)
(define-constant ERR-NOT-YET u101)

;; 🎁 Create a new treasure chest
(define-public (create-chest (beneficiary principal) (unlock-block uint))
  (let ((id (+ u1 (var-get chest-id))))
    (begin
      (var-set chest-id id)
      (map-set chests { id: id }
        { beneficiary: beneficiary,
          unlock-block: unlock-block,
          balance: u0,
          opened: false })
      (ok id)
    )
  )
)

;; 💰 Deposit into a chest
(define-public (deposit (id uint) (amount uint))
  (let ((chest (map-get? chests { id: id })))
    (match chest chest-data
      (begin
        (asserts! (not (get opened chest-data)) (err ERR-OPENED))
        (as-contract (stx-transfer? amount tx-sender (contract-caller)))
        (map-set chests { id: id }
          { beneficiary: (get beneficiary chest-data),
            unlock-block: (get unlock-block chest-data),
            balance: (+ (get balance chest-data) amount),
            opened: false })
        (ok true)
      )
      (err u404) ;; chest not found
    )
  )
)

;; 🔓 Open chest (anyone can trigger, only after unlock-block)
(define-public (open-chest (id uint))
  (let ((chest (map-get? chests { id: id })))
    (match chest chest-data
      (begin
        (asserts! (not (get opened chest-data)) (err ERR-OPENED))
        (asserts! (>= block-height (get unlock-block chest-data)) (err ERR-NOT-YET))
        (as-contract (stx-transfer? (get balance chest-data) (contract-caller) (get beneficiary chest-data)))
        (map-set chests { id: id }
          { beneficiary: (get beneficiary chest-data),
            unlock-block: (get unlock-block chest-data),
            balance: u0,
            opened: true })
        (ok (get beneficiary chest-data))
      )
      (err u404)
    )
  )
)

;; --- views ---
(define-read-only (get-chest (id uint)) (map-get? chests { id: id }))
(define-read-only (get-last-id) (var-get chest-id))
