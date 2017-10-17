function _set_color_by_test
  if test $argv
    set_color green
  else
    set_color red
  end
end

function _set_color_by_git_dirty
  _set_color_by_test (git status 2> /dev/null | tail -n1 | grep -i 'clean')
end

function _set_color_by_pwd_writable
  _set_color_by_test -w '.'
end

function _get_current_git_branch
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
end

function fish_prompt
  printf '%s%s' (set_color normal) (date +%H:%M:%S)
  printf ' %s%s' (_set_color_by_pwd_writable) (prompt_pwd)

  # TODO: Could we walk up the dir tree to check and not be too slow?
  if test -d '.git'
    printf '%s[%s%s%s]' (set_color normal) (_set_color_by_git_dirty) (_get_current_git_branch) (set_color normal)
  end

  printf '%s$ ' (set_color normal)
end
