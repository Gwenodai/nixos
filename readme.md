# Documentation

This documentation is currently WIP. So far all programs and services have finished documentation.

---

### Aspect Naming Convention

Aspect (folder) names may include a suffix: `[H]`, `[U]`, or `[HU]`. This indicates both that it is a consumable, predefined aspect and whether its contents are designed for hosts, users, or both.

| Suffix | Target Context | Usage Instructions |
|---|---|---|
| **[H]** | **Hosts** | Include in hosts. |
| **[U]** | **Users** | Include in users. |
| **[HU]** | **Both** | Include in both for full functionality (contains sub-aspects for both). |

---

### Aspect Index

<details open>
<summary><b>Flake Structure</b></summary>

> Highlighted directories indicate that they contain consumable aspects.

```mermaid
---
config:
  flowchart:
    curve: bumpX
---
flowchart TD
  classDef bold stroke:#4ce, stroke-width:3px

  modules{{"modules"}}
    batteries["`**batteries**`"]@{shape: das}
    core["`**core**`"]@{shape: processes}
    games["`**games**`"]:::bold@{shape: processes}
    hosts["`**hosts**`"]@{shape: processes}
    programs["`**programs**`"]:::bold@{shape: processes}
    services["`**services**`"]:::bold@{shape: processes}
    _style["`**style**`"]:::bold@{shape: processes}
    system["`**system**`"]:::bold@{shape: processes}
    users["`**users**`"]@{shape: processes}
    window-managers["`**window-managers**`"]:::bold@{shape: processes}

  modules --> batteries
  modules --> core
  modules ==> games
  modules --> hosts
  modules ==> programs
  modules ==> services
  modules ==> _style
  modules ==> system
  modules --> users
  modules ==> window-managers
```
</details>

#### Programs

<details>
<summary><b>View Programs Aspect Structure</b></summary>

```mermaid
---
config:
  flowchart:
    curve: bumpX
---
flowchart TD
  classDef bold stroke:#4ce, stroke-width:3px

  programs{{"programs"}}
    p_browser["`**browser [U]**`"]:::bold@{shape: lin-rect}
    p_calendar["`**calendar [U]**`"]:::bold@{shape: lin-rect}
    p_cli["`**cli [HU]**`"]:::bold@{shape: lin-rect}
    p_dconf-editor["`**dconf-editor [U]**`"]:::bold@{shape: lin-rect}
    p_files["`**files [U]**`"]:::bold@{shape: lin-rect}
    p_messaging["`**messaging [U]**`"]:::bold@{shape: lin-rect}
    p_shell["`**shell [U]**`"]:::bold@{shape: lin-rect}
    p_spotify["`**spotify [U]**`"]:::bold@{shape: lin-rect}
    p_vscode["`**vscode [U]**`"]:::bold@{shape: lin-rect}

  programs ==> p_browser
  programs ==> p_calendar
  programs ==> p_cli
  programs ==> p_dconf-editor
  programs ==> p_files
  programs ==> p_messaging
  programs ==> p_shell
  programs ==> p_spotify
  programs ==> p_vscode
```
</details>

Most of these aspects are generally intended for **users**, but some are desinged for hosts.

- [Web Browsers (browser)](../../wiki/browser)
- [Calendars (calendar)](../../wiki/calendar)
- [CLI-Tools (cli)](../../wiki/cli)
- [Dconf Debugging (dconf-editor)](../../wiki/dconf-editor)
- [File Explorers (files)](../../wiki/files)
- [Github tools (git)](../../wiki/git)
- [Messaging Applications (messaging)](../../wiki/messaging)
- [Shells & Shell Addons (shell)](../../wiki/shell)
- [Spotify Music Player (spotify)](../../wiki/spotify)
- [Terminal Emulators (terminal)](../../wiki/terminal)
- [Coding (vscode)](../../wiki/vscode)


#### Services

<details>
<summary><b>View Services Aspect Structure</b></summary>

```mermaid
---
config:
  flowchart:
    curve: bumpX
---
flowchart TD
  classDef bold stroke:#4ce, stroke-width:3px

  services{{"services"}}
    s_ananicy["`**ananicy [H]**`"]:::bold@{shape: lin-rect}
    s_audio["`**audio [H]**`"]:::bold@{shape: lin-rect}
    s_coolercontrol["`**coolercontrol [H]**`"]:::bold@{shape: lin-rect}
    s_display-manager["`**display-manager [H]**`"]:::bold@{shape: lin-rect}
    s_kde-connect["`**kde-connect [H]**`"]:::bold@{shape: lin-rect}
    s_keyring["`**keyring [H]**`"]:::bold@{shape: lin-rect}
    s_lact["`**lact [H]**`"]:::bold@{shape: lin-rect}
    s_polkit["`**polkit [U]**`"]:::bold@{shape: lin-rect}
    s_ssh["`**ssh**`"]@{shape: lin-rect}

  services ==> s_ananicy
  services ==> s_audio
  services ==> s_coolercontrol
  services ==> s_display-manager
  services ==> s_kde-connect
  services ==> s_keyring
  services ==> s_lact
  services ==> s_polkit
  services --> s_ssh
```
</details>

Most of these aspects are generally intended for **hosts**, but some are desinged for users.

- [Auto Nice Daemon (ananicy)](../../wiki/ananicy)
- [Audio Services (audio)](../../wiki/audio)
- [CoolerControl (coolercontrol)](../../wiki/coolercontrol)
- [Display Managers (display-manager)](../../wiki/display-manager)
- [KDE Connect (kde-connect)](../../wiki/kde-connect)
- [Keyring Services (keyring)](../../wiki/keyring)
- [LACT GPU Monitoring (lact)](../../wiki/lact)
- [Polkit Services (polkit)](../../wiki/polkit)
- [SSH Services (ssh)](../../wiki/ssh)