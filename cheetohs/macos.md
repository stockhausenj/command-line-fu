# macOS

## Processes
View launch daemons.

`ls /System/Library/LaunchDaemons/`

View launch agents.

`ls /System/Library/LaunchAgents/`

Disable launch agent.

`launchctl unload <agent>.plist`

## Interface
### Windows
Minimize all windows.

`Command + Option + <click on desktop>`

Minimize all windows except the one that is active.

`Command + Option + H`

## Gaming
### WoW
#### Enable Shift Modifiers
```
defaults write com.blizzard.worldofwarcraft disable-expose-fix -bool YES
```
