  ADR PROGRAM
PROGRAM
  TST '.SYNTAX'
  BF L1
  ID
  BE
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
  TB
  CL 'END'
  NL
L1
L3
  R
ST
  ID
  BF L4
  CI
  NL
  TST '='
  BE
  CLL EX1
  BE
  TST ';'
  BE
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
  GN1
  NL
L6
L10
  R
EX2
  CLL EX3
  BF L11
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
  GN1
  NL
L14
L19
  R
EX3
  ID
  BF L20
  TB
  CL 'CLL '
  CI
  NL
L20
  BT L21
  SR
  BF L22
  TB
  CL 'TST '
  CI
  NL
L22
  BT L21
  TST '.ID'
  BF L23
  TB
  CL 'ID'
  NL
L23
  BT L21
  TST '.NUMBER'
  BF L24
  TB
  CL 'NUM'
  NL
L24
  BT L21
  TST '.STRING'
  BF L25
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
  TB
  CL 'SET'
  NL
L27
  BT L21
  TST '$'
  BF L28
  GN1
  NL
  CLL EX3
  BE
  TB
  CL 'BT '
  GN1
  NL
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
  BT L31
  TST '{'
  BF L32
L33
  CLL OUT1
  BT L33
  SET
  BE
  TST '}'
  BE
L32
L31
  R
OUT1
  TST '*'
  BF L34
  TB
  CL 'CI'
  NL
L34
  BT L35
  SR
  BF L36
  TB
  CL 'CL '
  CI
  NL
L36
  BT L35
  TST '#'
  BF L37
  TB
  CL 'GN1'
  NL
L37
  BT L35
  TST '.NL'
  BF L38
  TB
  CL 'NL'
  NL
L38
  BT L35
  TST '.LB'
  BF L39
  TB
  CL 'LB'
  NL
L39
  BT L35
  TST '.TB'
  BF L40
  TB
  CL 'TB'
  NL
L40
  BT L35
  TST '.LM+'
  BF L41
  TB
  CL 'LMI'
  NL
L41
  BT L35
  TST '.LM-'
  BF L42
  TB
  CL 'LMD'
  NL
L42
L35
  R
  END
