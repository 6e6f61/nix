## Colours
# Colour of inactive tags visible on another monitor
INACTIVE_VISIBLE="%{F#707880}"
# Colour of the active tag
ACTIVE="%{F#8ABEB7}"
# Colour of inactive tags with open windows
INACTIVE="%{F#373B41}"

# Kill other instances
if [ $(pgrep -cf lemonbar) -gt 1 ]
then
  pkill -of lemonbar
fi

# Print the title of the active window of the specified tag
function active_window() {
  active_window_id=$(herbstclient layout "$1" --title | cut -d' ' -f3)
  active_window_raw=$(herbstclient list_clients --tag="$1" --title | awk -v awi="$active_window_id" '$1 == awi {for (i=2; i<NF; i++) printf $i " "; print $NF}')
  if [ ${#active_window_raw} -ge $2 ]
  then
    # This is not pretty
    echo -n "[$(echo ${active_window_raw} | head -c $2)...] "
  else
    echo -n "[${active_window_raw}] "
  fi
}

# Print every tag with a window, coloured by its status, along with the name of its active window.
function print_tags() {
  for tag in $(herbstclient tag_status)
  do
    tag_name="${tag:1}"
    case $tag in
      # Non-empty, visible on a different monitor
      -*)
        echo -ne "${INACTIVE_VISIBLE}${tag_name}"
        active_window $tag_name $1
        ;;
      # Active
      \#*)
        echo -ne "${ACTIVE}${tag_name}"
        active_window $tag_name $1
        ;;
      # Inactive, open windows
      :*) 
        echo -ne "${INACTIVE}${tag_name}"
        active_window $tag_name $1
        ;;
      # Inactive, no windows and urgent window respectively
      .* | !*)
        ;;
    esac
  done
}

function display_bar() {
  ## Bar: Left side
  echo -n "%{l}"
  print_tags 25

  ## Bar: Middle

  ## Bar: Right side
  echo -n "%{r}"
  echo -n "${ACTIVE}"
  echo -n "$(date '+%a %b %d, %T')"
}

monitors=($(xrandr | sed -n "s/ connected.*//p"))
while true
do
  for i in "${!monitors[@]}"
  do
    echo -n "%{S${i}}"
    display_bar
  done
  echo
  sleep .25
done