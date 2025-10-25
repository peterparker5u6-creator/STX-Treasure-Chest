(impl-trait 'SP3FBR2AGK5H9QBDH3EEN6DF8EK8JY7RX8QJ5SVTE.sip-010-trait-ft-standard.sip-010-trait)

(define-fungible-token spark-token u500000)

(define-constant ERR-ZERO-AMOUNT (err u100))
(define-constant ERR-NOT-AUTHORIZED (err u101))

;; Track STX donations
(define-map donations
    principal
    uint
)

;; Donate STX to Spark Project
(define-public (donate (stx-amount uint))
    (let (
            (caller tx-sender)
            (tokens-to-mint (/ stx-amount u50)) ;; 50 uSTX = 1 token
        )
        (asserts! (> stx-amount u0) ERR-ZERO-AMOUNT)
        (try! (stx-transfer? stx-amount tx-sender (as-contract tx-sender)))
        (map-set donations caller
            (+ (default-to u0 (map-get? donations caller)) stx-amount)
        )
        (try! (ft-mint? spark-token tokens-to-mint caller))
        (ok tokens-to-mint)
    )
)

;; SIP-010 for Spark Token
(define-read-only (get-name)
    (ok "Spark Token")
)

(define-read-only (get-symbol)
    (ok "SPARK")
)

(define-read-only (get-decimals)
    (ok u6)
)

(define-read-only (get-balance (account principal))
    (ok (ft-get-balance spark-token account))
)

(define-read-only (get-total-supply)
    (ok (ft-get-supply spark-token))
)

(define-read-only (get-token-uri)
    (ok none)
)

(define-public (transfer
        (amount uint)
        (sender principal)
        (recipient principal)
        (memo (optional (buff 34)))
    )
    (begin
        (asserts! (is-eq tx-sender sender) ERR-NOT-AUTHORIZED)
        (try! (ft-transfer? spark-token amount sender recipient))
        (match memo
            to-print (print to-print)
            0x
        )
        (ok true)
    )
)