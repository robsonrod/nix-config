{ pkgs }:

pkgs.writeShellApplication {
  name = "quickrec";

  runtimeInputs = with pkgs; [
    wf-recorder
  ];

  text = ''
    if pgrep -x "wf-recorder" >/dev/null; then
        pkill -INT -x wf-recorder
        notify-send -h string:wf-recorder:record -t 1000 "Finished Recording"
        exit 0
    fi

    for i in 3 2 1; do
        notify-send \
            -h string:wf-recorder:record \
            -t 1000 \
            "Recording in:" \
            "<span color='#90a4f4' font='26px'><i><b>$i</b></i></span>"

        sleep 1
    done

    datetime=$(date +%m-%d-%Y-%H:%M:%S)

    mkdir -p "$HOME/Videos"

    wf-recorder \
        --bframes max_b_frames \
        -f "$HOME/Videos/$datetime.mp4"
  '';
}
