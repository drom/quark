(module
  (type $type0 (func (result i32)))
  (table 0 anyfunc)
  (memory 1)
  (export "memory" memory)
  (export "_Z11countPrimesv" $func0)
  (func $func0 (result i32)
    (local $nSieve i32) (local $nPrimes i32) (local $var2 i32) (local $var3 i32) (local $var4 i32) (local $trial i32) (local $sqr  i32) (local $var7 i32) (local $var8 i32)
                                  ;; fedcba987654321#
    i32.const 0
    i32.const 4                   ;; +             +    4
                                  ;;  ++++        +     4016
    i32.store offset=4016         ;;      +      +      !       // sieve[0] = 4;
    i32.const 0
    i32.const 2                   ;;       +    +       2
                                  ;;        ++ +        16
    i32.store offset=16           ;; +             +    !       // primes[0] = 2;
    i32.const 0
    i32.const 0
                                  ;;  ++++        +     8016    (8016)
                                  ;;             +      dup     (8016 8016)
    i32.load offset=8016          ;;      +     +       @       (8016 n)
    i32.const 1                   ;;       +   +        1       (8016 n 1)
    i32.add                       ;;          +         +       (8016 n)
                                  ;;         +          dup     (8016 n n)
    tee_local $nSieve             ;; +             +    0!      (8016 n)        // nSieve
                                  ;;              +     swap    (n 8016)
    i32.store offset=8016         ;;  +          +      !
    i32.const 3                   ;;   +        +       3
    set_local $trial              ;;    +      +        5!      // trial = 3;
    i32.const 1                   ;;     +    +         1
    set_local $nPrimes            ;;      +  +          1!      // nPrimes = 1;
    i32.const 2                   ;;       ++           2       // sqr = 2;
    set_local $sqr                ;;                            (sqr)

    loop $label0                  ;; fedcba987654321#   <-      (sqr)
      get_local $sqr              ;;                            (sqr)
      get_local $sqr              ;;               x    dup     (sqr sqr)
                                  ;;              x     dup     (sqr sqr sqr)
      i32.mul                     ;; x           x      *       (sqr sqr*sqr)
      set_local $var8             ;;            x       swap    (sqr*sqr sqr)
      get_local $sqr
      i32.const 1                 ;;  x        x        1       (sqr*sqr sqr 1)
      i32.add                     ;;          x         +       (sqr*sqr sqr+1)
                                  ;;         x          dup     (sqr*sqr sqr' sqr')
      tee_local $var3             ;;   x    x           3!      (sqr*sqr sqr')
      set_local $sqr              ;;       x            swap    (var6 sqr*sqr)
      get_local $var8             ;;
      get_local $trial            ;;    x x             5@      (var6 sqr*sqr trial)
      i32.le_s                    ;; x             x    <=      (var6 f)
                                  ;;  xx          x     label0  (var6 f label0)
      br_if $label0               ;;             x      branch? (var6)

      block $label1
        get_local $nSieve         ;;    x       x       0@      (var6 nSieve)
        i32.const 1               ;;     x     x        1       (var6 nSieve 1)
        i32.lt_s                  ;;      x   x         <       (var6 f)
                                  ;;       xxx          label1  (var6 f label1)
        br_if $label1             ;;               x    branch? (var6)
        get_local $var3           ;;  x           x     3@      (var6 var3)
                                  ;;             x      dup     (var6 var3 var3)
        i32.const -1              ;;           xx       -1      (var6 var3 var3 -1)
        i32.add                   ;;          x         +       (var6 var3 var3-1)
        set_local $var2           ;;   x     x          2!      (var6 var3)
        get_local $var3
        i32.const -2              ;;    x   x           -2      (var6 var3 -2)
        i32.add                   ;;       x            +       (var6 var3-2)
        set_local $sqr            ;;      x             nip     (var3-2)

        i32.const 0               ;; x             x    0       (var3-2 0)
        set_local $var7

        block $label5 block $label2
          loop $label6            ;; fedcba987654321#           ($var7)
            get_local $var7       ;;                            ($var7)
            i32.const 2           ;; x             x    2       ($var7 2)
            i32.shl               ;;  x           x     lshift  ($var7<<2)
                                  ;;             x      dup     ($var8 $var8)
            tee_local $var8       ;;
            i32.const 16          ;;    xx     x        16      ($var8 $var8 16)
            i32.add               ;;          x         +       ($var8 $var8+16)
            i32.load              ;;      x  x          @       ($var8 $var3)
                                  ;;
            tee_local $var3       ;;        x           dup     ($var8 $var3 $var3)
            get_local $var2       ;; x             x    2@      ($var8 $var3 $var3 $var2)
            i32.ge_s              ;;  x           x     >=      ($var8 $var3 $var3>=$var2)
                                  ;;   xx        x      label2  ($var8 $var3 $var3>=$var2 label2)
            br_if $label2         ;;            x       branch? ($var8 $var3)

            block $label3
              get_local $var8     ;;      x  x          8@
              i32.const 4016      ;; xxxx          x    4016
              i32.add             ;;              x     +
                                  ;;             x      dup
              tee_local $var4     ;;     x      x       4!
              i32.load            ;;      x    x        @
                                  ;;          x         dup
              tee_local $var8     ;;       x x          8!
              get_local $trial    ;; x             x    5@        (trial)
              i32.ge_s            ;;  x           x     >=
                                  ;;   xx        x      label3
              br_if $label3       ;;            x       branch?

              loop $label4        ;; fedcba987654321#
                get_local $var8   ;; x             x    8@        (var8)
                get_local $var3   ;;  x           x     3@        (var8 var3)
                i32.add           ;;             x      +         (var8')
                                  ;;            x       dup       (var8' var8')
                tee_local $var8   ;;   x       x        8!        (var8')
                get_local $trial  ;;    x     x         5@        (var8' trial)
                i32.lt_s          ;;     x   x          <         (f)
                                  ;;      xxx           label4    (f label4)
                br_if $label4     ;;               x    branch?   ()
              end $label4

              get_local $var4     ;; x            x     8@
              get_local $var8     ;;  x          x      4@
              i32.store           ;;   x        x       !

            end $label3           ;; fedcba987654321#

            get_local $var8       ;; x             x    8@
            get_local $trial      ;;  x           x     5@        (trial)
            i32.eq                ;;   x         x      =
                                  ;;    xx      x       label5
            br_if $label5         ;;           x        branch?
            get_local $var7       ;;      x   x         7@
            i32.const 1           ;;       x x          1
            i32.add               ;;        x           +
                                  ;;               x    dup
            tee_local $var7       ;; x            x     7!
            get_local $nSieve     ;;  x          x      0@
            i32.lt_s              ;;   x        x       <=
                                  ;;    xx     x        label6
            br_if $label6         ;;          x         branch?
                                  ;;      xx x          label1
            br $label1            ;;        x           branch
          end $label6

        end $label2               ;; fedcba987654321#             (nSieve)

          block $label7
            get_local $nSieve     ;;                              (nSieve)
                                  ;;               x    dup
            i32.const 999         ;; xxxx         x     999       (nSieve 999)
                                  ;;             x      over      (nSieve 999 nSieve)
            i32.gt_s              ;;     x      x       <         (nSieve f)
                                  ;;      xx   x        label7    (nSieve f label7)
            br_if $label7         ;;          x         branch?   (nSieve)
            i32.const 0
            get_local $nSieve     ;;         x          dup       (nSieve nSieve)
            i32.const 1           ;; x             x    1         (nSieve nSieve 1)
            i32.add               ;;              x     +         (nSieve nSieve+1)
                                  ;;             x      dup       (nSieve nSieve+1 nSieve+1)
            tee_local $var8       ;;  x         x       8!        (nSieve nSieve+1)
                                  ;;   xxxx    x        8016      (nSieve nSieve+1 8016)
            i32.store offset=8016 ;;       x  x         !         (nSieve)
                                  ;;        xx          5@        (nSieve trial)
                                  ;;               x    dup       (nSieve trial trial)
                                  ;; x            x     *         (nSieve trial*trial)
            get_local $nSieve     ;;             x      over      (nSieve trial*trial nSieve)
            i32.const 2           ;;  x         x       2         (nSieve trial*trial nSieve 2)
            i32.shl               ;;   x       x        lshift    (nSieve trial*trial nSieve<<2)
                                  ;;          x         dup       (nSieve trial*trial nSieve<<2 nSieve<<2)
            tee_local $var3       ;;    x    x          3!        (nSieve trial*trial nSieve<<2)
            i32.const 4016        ;; xxxx          x    4016      (nSieve trial*trial nSieve<<2 4016)
            i32.add               ;;              x     +         (nSieve trial*trial nSieve<<2+4016)
            get_local $trial
            get_local $trial
            i32.mul
            i32.store             ;;     x       x      !
                                  ;;      x     x       5@        (trial)
            get_local $var3       ;;       x   x        3@
            i32.const 16          ;;        xxx         16
            i32.add               ;;               x    +
            get_local $trial
            i32.store             ;; x            x     !
            get_local $var8       ;;  x          x      8@
            set_local $nSieve     ;;   x        x       0!

          end $label7             ;; fedcba987654321#             (nSieve)

          get_local $nPrimes      ;; x             x    1@        (nPrimes)
          i32.const 1             ;;  x           x     1         (nPrimes 1)
          i32.add                 ;;             x      +         (nPrimes+1)
          set_local $nPrimes      ;;   x        x       1!        ()

        end $label5               ;; fedcba987654321#

        get_local $trial          ;; x             x    5@        (trial)
        i32.const 1               ;;  x           x     1         (trial 1)
        i32.add                   ;;             x      +         (trial+1)
        set_local $trial          ;;   x        x       5!        ()
                                  ;;    xx     x        label0
        br $label0                ;;          x         branch

      end $label1                 ;; fedcba987654321#

    end $label0

    get_local $nPrimes            ;; x             x    1@        (nPrimes)

  )
  (data (i32.const 8016)
    "\00\00\00\00"
  )
)
