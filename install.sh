#!/bin/zsh
# Installs the script and a launchd agent that runs it every 30s. Re-run to update.
set -e
label=local.teams-now-playing
bin=$HOME/.local/bin/teams-now-playing
plist=$HOME/Library/LaunchAgents/$label.plist

mkdir -p ${bin:h} ${plist:h}
install -m 755 ${0:A:h}/teams-now-playing $bin

cat > $plist <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>$label</string>
  <key>ProgramArguments</key>
  <array>
    <string>$bin</string>
  </array>
  <key>StartInterval</key>
  <integer>30</integer>
  <key>RunAtLoad</key>
  <true/>
  <key>StandardErrorPath</key>
  <string>/tmp/teams-now-playing.err</string>
</dict>
</plist>
EOF

launchctl bootout gui/$UID/$label 2>/dev/null || true
launchctl bootstrap gui/$UID $plist
echo "Installed. Errors go to /tmp/teams-now-playing.err"
