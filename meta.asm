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
    BF L5
L5
    BT L6
    TST ';'
    BF L7
L7
L6
    BE
    CL 'R'
    OUT
L4
L8
    R
EX1
    CLL EX2
    BF L9
L10
    TST '/'
    BF L11
    CL 'BT '
    GN1
    OUT
    CLL EX2
    BE
L11
L12
    BT L10
    SET
    BE
    LB
    GN1
    OUT
L9
L13
    R
EX2
    CLL EX3
    BF L14
    CL 'BF '
    GN1
    OUT
L14
    BT L15
    CLL OUTPUT
    BF L16
L16
L15
    BF L17
L18
    CLL EX3
    BF L19
    CL 'BE'
    OUT
L19
    BT L20
    CLL OUTPUT
    BF L21
L21
L20
    BT L18
    SET
    BE
    LB
    GN1
    OUT
L17
L22
    R
EX3
    ID
    BF L23
    CL 'CLL '
    CI
    OUT
L23
    BT L24
    SR
    BF L25
    CL 'TST '
    CI
    OUT
L25
    BT L24
    TST '.ID'
    BF L26
    CL 'ID'
    OUT
L26
    BT L24
    TST '.NUMBER'
    BF L27
    CL 'NUM'
    OUT
L27
    BT L24
    TST '.STRING'
    BF L28
    CL 'SR'
    OUT
L28
    BT L24
    TST '('
    BF L29
    CLL EX1
    BE
    TST ')'
    BE
L29
    BT L24
    TST '.EMPTY'
    BF L30
    CL 'SET'
    OUT
L30
    BT L24
    TST '$'
    BF L31
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
L31
L24
    R
OUTPUT
    TST '.OUT'
    BF L32
    TST '('
    BE
L33
    CLL OUT1
    BT L33
    SET
    BE
    TST ')'
    BE
L32
    BT L34
    TST '.LABEL'
    BF L35
    CL 'LB'
    OUT
    CLL OUT1
    BE
L35
L34
    BF L36
    CL 'OUT'
    OUT
L36
L37
    R
OUT1
    TST '*1'
    BF L38
    CL 'GN1'
    OUT
L38
    BT L39
    TST '*2'
    BF L40
    CL 'GN2'
    OUT
L40
    BT L39
    TST '*'
    BF L41
    CL 'CI'
    OUT
L41
    BT L39
    SR
    BF L42
    CL 'CL '
    CI
    OUT
L42
L39
    R
    END
