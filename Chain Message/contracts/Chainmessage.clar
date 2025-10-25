;; contracts/chainmessage.clar
;; ChainMessage – one permanent message per wallet

(define-map messages
  { owner: principal }
  { content: (string-ascii 160), block: uint }
)

(define-constant ERR-ALREADY-WRITTEN u100)

;; Write your permanent message (max 160 chars)
(define-public (write (msg (string-ascii 160)))
  (let ((existing (map-get? messages { owner: tx-sender })))
    (if (is-some existing)
        (err ERR-ALREADY-WRITTEN)
        (begin
          (map-set messages { owner: tx-sender }
            { content: msg, block: block-height })
          (ok true)
        )
    )
  )
)

;; View someone’s message
(define-read-only (get-message (who principal))
  (map-get? messages { owner: who })
)
;; View your own message
(define-read-only (get-my-message)
  (map-get? messages { owner: tx-sender })
)
;; View total messages count
(define-read-only (total-messages)
  (map-length messages)
)
;; View all messages (for explorers)
(define-read-only (all-messages)
  (map-values messages)
)
;; View all message senders (for explorers)
(define-read-only (all-senders)
  (map-keys messages)
)

;; End of contract
