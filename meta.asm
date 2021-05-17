  ADR PROGRAM
PROGRAM
  TST '.SYNTAX'
  BF L1
  ID
  BE
  LB
  TB
  CL 'ADR '
  CI
  NL
L2
  CLL ST
  BT L2
  SET
  BE
  TST '.END'
  BE
  LB
  TB
  CL 'END'
  NL
L1
L3
  R
ST
  ID
  BF L4
  LB
  CI
  NL
  TST '='
  BE
  CLL EX1
  BE
  TST ';'
  BE
  LB
  TB
  CL 'R'
  NL
L4
L5
  R
EX1
  CLL EX2
  BF L6
L7
  TST '/'
  BF L8
  LB
  TB
  CL 'BT '
  GN1
  NL
  CLL EX2
  BE
L8
L9
  BT L7
  SET
  BE
  LB
  GN1
  NL
L6
L10
  R
EX2
  CLL EX3
  BF L11
  LB
  TB
  CL 'BF '
  GN1
  NL
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
  LB
  TB
  CL 'BE'
  NL
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
  NL
L14
L19
  R
EX3
  ID
  BF L20
  LB
  TB
  CL 'CLL '
  CI
  NL
L20
  BT L21
  SR
  BF L22
  LB
  TB
  CL 'TST '
  CI
  NL
L22
  BT L21
  TST '.ID'
  BF L23
  LB
  TB
  CL 'ID'
  NL
L23
  BT L21
  TST '.NUMBER'
  BF L24
  LB
  TB
  CL 'NUM'
  NL
L24
  BT L21
  TST '.STRING'
  BF L25
  LB
  TB
  CL 'SR'
  NL
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
  LB
  TB
  CL 'SET'
  NL
L27
  BT L21
  TST '$'
  BF L28
  LB
  GN1
  NL
  CLL EX3
  BE
  LB
  TB
  CL 'BT '
  GN1
  NL
  LB
  TB
  CL 'SET'
  NL
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
L31
  R
OUT1
  TST '*'
  BF L32
  LB
  TB
  CL 'CI'
  NL
L32
  BT L33
  SR
  BF L34
  LB
  TB
  CL 'CL '
  CI
  NL
L34
  BT L33
  TST '#'
  BF L35
  LB
  TB
  CL 'GN1'
  NL
L35
  BT L33
  TST '.NL'
  BF L36
  LB
  TB
  CL 'NL'
  NL
L36
  BT L33
  TST '.LB'
  BF L37
  LB
  TB
  CL 'LB'
  NL
L37
  BT L33
  TST '.TB'
  BF L38
  LB
  TB
  CL 'TB'
  NL
L38
  BT L33
  TST '.LM+'
  BF L39
  LB
  TB
  CL 'LMI'
  NL
L39
  BT L33
  TST '.LM-'
  BF L40
  LB
  TB
  CL 'LMD'
  NL
L40
L33
  R
  END
