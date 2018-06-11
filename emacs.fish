function init --on-event init_emacs
  function __major_version
    if test -n "$argv"
      set -l full_metadata (eval $argv --version)
      set -l major_version (echo $full_metadata | sed -r  's/^[^0-9]*([0-9]+).*/\1/')
      echo $major_version
    end
  end

  function __set_editor
    if not set -q EDITOR
      set -gx EDITOR emacs
    end
  end

  function __add_functions_to_path
    set emacs_functions $OMF_PATH/pkg/emacs/functions
    set fish_function_path $emacs_functions $fish_function_path
  end

  if not set -q __emacs
    set __emacs (which emacs)
  end

  if not set -q __emacs_version
    set __emacs_version (__major_version $__emacs)
  end

  if test "$__emacs_version" -gt 23
    __set_editor
    __add_functions_to_path
  end

  functions -e __major_version
  functions -e __set_editor
  functions -e __add_functions_to_path
end

function emacs
  __launch_emacs $argv --no-wait
end
