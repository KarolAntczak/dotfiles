# greetd + Noctalia Greeter

Display manager: `greetd` running `noctalia-greeter` (bundles its own wlroots
compositor), Hyprland preselected as the default session, fingerprint-or-password
auth.

Nothing here is stowed — these are system files. Copy them into place.

| repo file | destination | owner |
|---|---|---|
| `etc/greetd/config.toml` | `/etc/greetd/config.toml` | root |
| `etc/pam.d/greetd` | `/etc/pam.d/greetd` | root |
| `var/lib/noctalia-greeter/greeter.toml` | `/var/lib/noctalia-greeter/greeter.toml` | `greeter` |
| `usr/local/share/wayland-sessions/hyprland.desktop` | same path | root |

## Deploy

```bash
# 1. install (pulls greetd, wlroots0.20)
yay -S noctalia-greeter

# 2. sanity-check the names baked into etc/greetd/config.toml
which noctalia-greeter-session      # expect /usr/bin/noctalia-greeter-session
noctalia-greeter sessions          # expect only "Hyprland" (see below)

# 3. copy the files
cd ~/Kody/dotfiles/greetd
sudo install -Dm644 etc/greetd/config.toml            /etc/greetd/config.toml
sudo install -Dm644 etc/pam.d/greetd                  /etc/pam.d/greetd
sudo install -Dm644 -o greeter -g greeter \
  var/lib/noctalia-greeter/greeter.toml               /var/lib/noctalia-greeter/greeter.toml
sudo install -Dm644 usr/local/share/wayland-sessions/hyprland.desktop \
  /usr/local/share/wayland-sessions/hyprland.desktop

# 4. enable it as the display manager
sudo systemctl enable greetd
```

Then sync wallpaper/palette/layout from the running shell:
**Settings → Security → Noctalia Greeter → Sync Now**
(or `sudo noctalia-greeter passwordless-sync enable kao` for automatic re-sync).

## Single session (no switcher)

The greeter lists every `.desktop` in the `wayland-sessions` dirs. The `hyprland`
package ships a `-uwsm` variant too; drop it so only "Hyprland" shows:

```bash
# /etc/pacman.conf, under [options]:
NoExtract = usr/share/wayland-sessions/hyprland-uwsm.desktop

sudo rm /usr/share/wayland-sessions/hyprland-uwsm.desktop
```

## Fingerprint

`etc/pam.d/greetd` does password-first, fingerprint-fallback: type the password
→ instant login; leave it empty and press Enter → fingerprint prompt. Requires an
enrolled finger (`fprintd-enroll`) and `fprintd` installed. `allow_empty_password`
/ `request_timeout = 0` in `greeter.toml` make the empty submit and the scan wait
work. A wrong (non-empty) password waits out the single 15s `pam_fprintd`
attempt before it's rejected — that's the cost of not prompting for a finger up
front.

## Clean login handoff (no terminal flash)

Two sources of the brief text flash between greeter and Hyprland:

1. **Kernel / systemd console + cursor.** Add to the `options` line in
   `/boot/loader/entries/arch.conf`:
   `quiet loglevel=3 vt.global_cursor_default=0`
2. **Hyprland's own "Welcome to Hyprland!" banner.** Handled by
   `usr/local/share/wayland-sessions/hyprland.desktop`, which redirects the
   session's stdout. `/usr/local/share` is scanned before `/usr/share` and the
   greeter dedupes by `Name=`, so this entry wins.

For a truly seamless boot-to-desktop, add `plymouth` (splash held until the
compositor starts) — bigger change, not done here.

## Recovery

If the greeter won't start, switch to a console TTY (Ctrl+Alt+F2 — getty there
uses `/etc/pam.d/login`, untouched by this) and:

```bash
sudo systemctl disable --now greetd
```

Then start Hyprland straight from the TTY (`dbus-run-session Hyprland`) to fix
things, or fall back to `greetd-tuigreet` by pointing `/etc/greetd/config.toml`
at it (`command = "tuigreet --cmd Hyprland"`).
