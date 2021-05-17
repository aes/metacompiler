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
  OUT
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
  TST ';'
  BE
  LB
  TB
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
  LB
  TB
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
  LB
  TB
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
  LB
  TB
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
  LB
  TB
  CL 'CLL '
  CI
  OUT
L20
  BT L21
  SR
  BF L22
  LB
  TB
  CL 'TST '
  CI
  OUT
L22
  BT L21
  TST '.ID'
  BF L23
  LB
  TB
  CL 'ID'
  OUT
L23
  BT L21
  TST '.NUMBER'
  BF L24
  LB
  TB
  CL 'NUM'
  OUT
L24
  BT L21
  TST '.STRING'
  BF L25
  LB
  TB
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
  LB
  TB
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
  LB
  TB
  CL 'BT '
  GN1
  OUT
  LB
  TB
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
L31
  BF L32
  LB
  TB
  CL 'OUT'
  OUT
L32
L33
  R
OUT1
  TST '*1'
  BF L34
  LB
  TB
  CL 'GN1'
  OUT
L34
  BT L35
  TST '*2'
  BF L36
  LB
  TB
  CL 'GN2'
  OUT
L36
  BT L35
  TST '*'
  BF L37
  LB
  TB
  CL 'CI'
  OUT
L37
  BT L35
  SR
  BF L38
  LB
  TB
  CL 'CL '
  CI
  OUT
L38
  BT L35
  TST '#'
  BF L39
  LB
  TB
  CL 'GN1'
  OUT
L39
  BT L35
  TST '.NL'
  BF L40
  LB
  TB
  CL 'NL'
  OUT
L40
  BT L35
  TST '.LB'
  BF L41
  LB
  TB
  CL 'LB'
  OUT
L41
  BT L35
  TST '.TB'
  BF L42
  LB
  TB
  CL 'TB'
  OUT
L42
  BT L35
  TST '.LM+'
  BF L43
  LB
  TB
  CL 'LMI'
  OUT
L43
  BT L35
  TST '.LM-'
  BF L44
  LB
  TB
  CL 'LMD'
  OUT
L44
L35
  R
  END
