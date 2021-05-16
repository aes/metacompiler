#!./meta.py
    ADR PROGRAM
PROGRAM
    TST '.SYNTAX'
    BF L1
    ID
    BE
    CL 'ADR '
    CI
    OUT
L2
    CLL ST
    BT L2
    SET
    BE
    TST '.END'
    BE
    CL 'END'
    OUT
L1
L3
    R
ST
    ID
    BF L4
    LB
    CI
    OUT
    TST '='
    BE
    CLL EX1
    BE
    TST '.,'
    BE
    CL 'R'
    OUT
L4
L5
    R
EX1
    CLL EX2
    BF L6
L7
    TST '/'
    BF L8
    CL 'BT '
    GN1
    OUT
    CLL EX2
    BE
L8
L9
    BT L7
    SET
    BE
    LB
    GN1
    OUT
L6
L10
    R
EX2
    CLL EX3
    BF L11
    CL 'BF '
    GN1
    OUT
L11
    BT L12
    CLL OUTPUT
    BF L13
L13
L12
    BF L14
L15
    CLL EX3
    BF L16
    CL 'BE'
    OUT
L16
    BT L17
    CLL OUTPUT
    BF L18
L18
L17
    BT L15
    SET
    BE
    LB
    GN1
    OUT
L14
L19
    R
EX3
    ID
    BF L20
    CL 'CLL '
    CI
    OUT
L20
    BT L21
    SR
    BF L22
    CL 'TST '
    CI
    OUT
L22
    BT L21
    TST '.ID'
    BF L23
    CL 'ID'
    OUT
L23
    BT L21
    TST '.NUMBER'
    BF L24
    CL 'NUM'
    OUT
L24
    BT L21
    TST '.STRING'
    BF L25
    CL 'SR'
    OUT
L25
    BT L21
    TST '('
    BF L26
    CLL EX1
    BE
    TST ')'
    BE
L26
    BT L21
    TST '.EMPTY'
    BF L27
    CL 'SET'
    OUT
L27
    BT L21
    TST '$'
    BF L28
    LB
    GN1
    OUT
    CLL EX3
    BE
    CL 'BT '
    GN1
    OUT
    CL 'SET'
    OUT
L28
L21
    R
OUTPUT
    TST '.OUT'
    BF L29
    TST '('
    BE
L30
    CLL OUT1
    BT L30
    SET
    BE
    TST ')'
    BE
L29
    BT L31
    TST '.LABEL'
    BF L32
    CL 'LB'
    OUT
    CLL OUT1
    BE
L32
L31
    BF L33
    CL 'OUT'
    OUT
L33
L34
    R
OUT1
    TST '*1'
    BF L35
    CL 'GN1'
    OUT
L35
    BT L36
    TST '*2'
    BF L37
    CL 'GN2'
    OUT
L37
    BT L36
    TST '*'
    BF L38
    CL 'CI'
    OUT
L38
    BT L36
    SR
    BF L39
    CL 'CL '
    CI
    OUT
L39
L36
    R
    END
