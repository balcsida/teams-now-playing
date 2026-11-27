# teams-now-playing

Shows the track playing in Apple Music as your Microsoft Teams status message on macOS:

> 🎵 Rundat [USB Bonus] — Chase & Status

A launchd agent polls Music every 30 seconds and updates Teams when the track changes. The status is cleared when playback stops.

## Requirements

- macOS with Apple Music
- [teams CLI](https://github.com/osodevops/ms-teams-cli), authenticated (`teams auth login`)
- `jq`

```sh
brew install osodevops/tap/teams-cli jq
```

## Install

```sh
./install.sh
```

The first time a track plays, macOS asks whether the agent may control Music. Allow it.

## Behaviour

- A status you typed by hand is never overwritten: only an empty status, or one starting with 🎵, is replaced.
- The status is shown when people message or @mention you ("Show when people message me").
- Each status expires after one hour, so it clears itself if the Mac sleeps mid-song. A single track looping for over an hour loses its status until the track changes.
- Errors are written to `/tmp/teams-now-playing.err`.

## Uninstall

```sh
launchctl bootout gui/$UID/local.teams-now-playing
rm ~/Library/LaunchAgents/local.teams-now-playing.plist ~/.local/bin/teams-now-playing
```
