{ pkgs, ... } :
let
  name = "git-auto-push";
in
{
  systemd.services.${name} = {
    description = "Automatically commit and push changes to GitHub";
    serviceConfig = {
      Type = "oneshot";
      User = "asungy";
      WorkingDirectory = "/home/asungy/dev/gambit";
    };
    path = [
      pkgs.bash
      pkgs.git
    ];
    script = ''
      bash -c '
        if ! git diff --quiet || ! git diff --cached --quiet; then
          git add -A &&
          git commit -m "Auto-commit on $(date)" &&
          git push origin main
        else
          echo "No changes to commit."
        fi
      '
    '';
  };

  systemd.timers.${name} = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "03:00"; # 3 AM daily
      Persistent = true;
      Unti = "${name}.service";
    };
  };
}
