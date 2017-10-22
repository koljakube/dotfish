function _print_indented --description 'print a string indented by n spaces'
  set n $argv[1]
  set str $argv[2]

  set indent (math $n + (string length $str))
  printf '%'$indent's' $str
end

function _pretty_uptime
  set boot_time string match --regex '\\d+' (sysctl -n kern.boottime | cut -f 4 -d ' ')
  set now_in_secs (date +%s)
  set uptime_sec (math (date '+%s') - (string match --regex '\\d+' (sysctl -n kern.boottime | cut -f 4 -d ' ')))
  # Subtract a week to correct the date for 1970.
  set weeks (date -r (math $uptime_sec) -u +'%-Ww ')
  set days_minus_one (math (date -r (math $uptime_sec) -u +'%-j') - 1)
  set rest (date -r (math $uptime_sec) -u +'d %-Hh %-Mm')
  echo -n $weeks$days_minus_one$rest
end

function _pretty_hostname
  hostname | sed -e 's/\\.local$//'
end

function fish_greeting
  if string match --quiet 'screen*' $TERM
    echo 'Hi.'
  else
    set label_color blue
    set value_color white
    set after_color F00

    set set_color_width (string length (set_color $value_color))
    set you_are  " You are:  "(set_color $value_color)(whoami)" "
    set uptime   " Uptime:   "(set_color $value_color)(_pretty_uptime)" "
    set hostname " Hostname: "(set_color $value_color)(_pretty_hostname)" "
    
    set fish_width 33
    set indent (math $COLUMNS - $fish_width - 1)
    _print_indented $indent '                 '(set_color F00)'___'; echo
    _print_indented $indent '  ___======____='(set_color FF7F00)'-'(set_color FF0)'-'(set_color FF7F00)'-='(set_color F00)')'; echo
    _print_indented $indent '/T            \_'(set_color FF0)'--='(set_color FF7F00)'=='(set_color F00)')'; echo
    echo -n (set_color $label_color)$you_are(set_color $after_color)
    _print_indented (math $indent - (string length $you_are) + $set_color_width) '[ \ '(set_color FF7F00)'('(set_color FF0)'0'(set_color FF7F00)')   '(set_color F00)'\~    \_'(set_color FF0)'-='(set_color FF7F00)'='(set_color F00)')'; echo
    _print_indented $indent ' \      / )J'(set_color FF7F00)'~~    \\'(set_color FF0)'-='(set_color F00)')'; echo
    echo -n (set_color $label_color)$hostname(set_color $after_color)
    _print_indented (math $indent - (string length $hostname) + $set_color_width) '  \\\\___/  )JJ'(set_color FF7F00)'~'(set_color FF0)'~~   '(set_color F00)'\)'; echo
    echo -n (set_color $label_color)$uptime(set_color $after_color)
    _print_indented (math $indent - (string length $uptime) + $set_color_width) '   \_____/JJJ'(set_color FF7F00)'~~'(set_color FF0)'~~    '(set_color F00)'\\'; echo
    _print_indented $indent '   '(set_color FF7F00)'/ '(set_color FF0)'\  '(set_color FF0)', \\'(set_color F00)'J'(set_color FF7F00)'~~~'(set_color FF0)'~~     '(set_color FF7F00)'\\'; echo
    _print_indented $indent '  (-'(set_color FF0)'\)'(set_color F00)'\='(set_color FF7F00)'|'(set_color FF0)'\\\\\\'(set_color FF7F00)'~~'(set_color FF0)'~~       '(set_color FF7F00)'L_'(set_color FF0)'_'; echo
    _print_indented $indent '  '(set_color FF7F00)'('(set_color F00)'\\'(set_color FF7F00)'\\)  ('(set_color FF0)'\\'(set_color FF7F00)'\\\)'(set_color F00)'_           '(set_color FF0)'\=='(set_color FF7F00)'__'; echo
    _print_indented $indent '   '(set_color F00)'\V    '(set_color FF7F00)'\\\\'(set_color F00)'\) =='(set_color FF7F00)'=_____   '(set_color FF0)'\\\\\\\\'(set_color FF7F00)'\\\\'; echo
    _print_indented $indent '          '(set_color F00)'\V)     \_) '(set_color FF7F00)'\\\\'(set_color FF0)'\\\\JJ\\'(set_color FF7F00)'J\)'; echo
    _print_indented $indent '                      '(set_color F00)'/'(set_color FF7F00)'J'(set_color FF0)'\\'(set_color FF7F00)'J'(set_color F00)'T\\'(set_color FF7F00)'JJJ'(set_color F00)'J)'; echo
    _print_indented $indent '                      (J'(set_color FF7F00)'JJ'(set_color F00)'| \UUU)'; echo
    _print_indented $indent '                       (UU)'(set_color normal); echo
  end
end

