import os
import socket
import subprocess
from datetime import datetime
from typing import List
from libqtile import bar, layout, widget, hook
from libqtile import qtile
from libqtile.config import Key, Screen, Group, Drag, Match
from libqtile.lazy import lazy

# Theme Choice
from themes import dracula
colors = dracula.init_colors()

#from themes import vault
#colors = vault.init_colors()


mod = "mod4"
mod2 = "control"
mod1 = "mod1"
home = os.path.expanduser("~")
folder = os.path.expanduser("~/.config/qtile")

today = datetime.today()
terminal = "kitty"
browser = "brave"

keys = [

# POWER KEYS
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "shift"], "q", lazy.spawn(home + "/.config/rofi/scripts/powermenu.sh")),

# APPS AND LAUNCHERS
# SUPER KEY
    Key([mod], "space", 
        lazy.spawn("dmenu_run"), desc="dmenu"),
    Key([mod], "t", 
        lazy.spawn("timeshift-launcher"), desc="timeshift"),
    Key([mod], "Return", 
        lazy.spawn(terminal), desc="kitty"),
    Key([mod], "b", 
        lazy.spawn(browser), desc="brave"),
    Key([mod], "c", 
        lazy.spawn("code"), desc="vscode"),
    Key([mod], "f", 
        lazy.spawn("pcmanfm"), desc="file manager"),
    Key([mod], "h", 
        lazy.spawn(terminal + " htop"), desc="htop"),
    Key([mod], "v", 
        lazy.spawn(terminal + " nvim"), desc="nvim"),
    Key([mod], "w", 
        lazy.spawn("qutebrowser"), desc="qutebrowser"),
    Key([mod], "d",
        lazy.spawn(home + "/.config/rofi/scripts/floating_launcher.sh"), desc="rofi"),
    Key([mod], "m", 
        lazy.spawn("mullvad-vpn"), desc="mullvad vpn"),
    Key([mod], "r", 
        lazy.spawn(home + "/.local/bin/newsboat-fix"), desc="RSS newsboat"),
    Key([mod], "g", 
        lazy.spawn("github-desktop"), desc="github desktop"),
    Key([mod], "i", 
        lazy.spawn("inkscape"), desc="inkscape"),
    Key([mod], "s",
        lazy.spawn("steam"), desc="steam"),
    Key([mod], "n", 
        lazy.spawn("notion-app-enhanced"), desc="notion"),
    Key([mod, "shift"], 
        "s", lazy.spawn("stacer"), desc="stacer"),
    Key([mod, "shift"], 
        "t", lazy.spawn("lxtask"), desc="task manager"),

# MULTIMEDIA/OTHER FUNCTIONS
    
    # INCREASE/DECREASE BRIGHTNESS
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl s +5%")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl s 5%-")),
    
    # INCREASE/DECREASE/MUTE VOLUME
    Key([], "XF86AudioMute", lazy.spawn("amixer -q sset Master toggle")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer -q sset Master 5%-")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer -q sset Master 5%+")),
    
    # Print Screen
    Key(
        [mod1, "shift"], "F12",
        lazy.spawn("scrot 'ArchLinux-%Y-%m-%d-%s_screenshot_$wx$h.jpg' -e 'mv $f $$(xdg-user-dir PICTURES)'")),
    Key(
        [mod1, "shift"], "s",
        lazy.spawn("scrot 'ArchLinux-%Y-%m-%d-%s_screenshot_$wx$h.jpg' -e 'mv $f $$(xdg-user-dir PICTURES)'")),
    Key(
        [mod], "F12",
        lazy.spawn("scrot 'ArchLinux-%Y-%m-%d-%s_screenshot_$wx$h.jpg' -e 'mv $f $$(xdg-user-dir PICTURES)'")),


# QTILE KEYS
# CTRL 
    # Switch between windows
    Key([mod2], "Left", lazy.layout.left(), desc="Move focus to left"),
    Key([mod2], "Right", lazy.layout.right(), desc="Move focus to right"),
    Key([mod2], "Down", lazy.layout.down(), desc="Move focus down"),
    Key([mod2], "Up", lazy.layout.up(), desc="Move focus up"),
   
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod2, "shift"], "Left", lazy.layout.shuffle_left()),
    Key([mod2, "shift"], "Right", lazy.layout.shuffle_right()),
    Key([mod2, "shift"], "Down", lazy.layout.shuffle_down()),
    Key([mod2, "shift"], "Up", lazy.layout.shuffle_up()),
    
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, mod2], "Right",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete(),
    ),
    Key([mod, mod2], "Left",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add(),
    ),
    Key([mod, mod2], "Up",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster(),
    ),
    Key([mod, mod2], "Down",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster(),
    ),

    # Layout changing
    Key([mod2], "space", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod2, "shift"], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([mod2, "shift"], "m", lazy.window.toggle_fullscreen()),
    Key([mod2, "shift"], "f", lazy.window.toggle_floating()),
    
    # Treetab controls
    Key(
        [mod2, mod1],
        "Up",
        lazy.layout.section_up(),
        desc="Move up a section in treetab",
    ),
    Key(
        [mod2, mod1],
        "Down",
        lazy.layout.section_down(),
        desc="Move down a section in treetab",
    ),
]


def init_layout_theme():
    return {
        "border_width": 2,
        "margin": 12,
        "border_focus": colors[8],
        "border_normal": colors[13],
    }


layout_theme = init_layout_theme()

layouts = [
    layout.MonadTall(**layout_theme),
    layout.Matrix(**layout_theme),
    layout.Stack(num_stacks=2, **layout_theme),
    layout.TreeTab(
        font="Hack Nerd Font",
        fontsize=11,
        sections=[" Workspace"],
        section_fontsize=12,
        border_width=2,
        bg_color=colors[14],
        active_bg=colors[9],
        active_fg=colors[14],
        inactive_bg=colors[9],
        inactive_fg=colors[14],
        margin_x=1,
        margin_y=1,
        padding_x=5,
        padding_y=5,
        section_top=10,
        section_bottom=20,
        level_shift=8,
        vspace=2,
        panel_width=210,
    ),
    layout.Floating(**layout_theme),
]

groups = []
group_names = ["1", "2", "3", "4", "5", "6"]
group_labels = [
    "",
    "",
    "",
    "",
    "",
    "",
]
group_layouts = [
    "floating",
    "monadtall",
    "monadtall",
    "monadtall",
    "monadtall",
    "floating",
]

for i in range(len(group_names)):
    groups.append(
        Group(
            name=group_names[i],
            layout=group_layouts[i].lower(),
            label=group_labels[i],
        )
    )

for i in groups:
    keys.extend(
        {
            # CHANGE WORKSPACES
            Key([mod], i.name, lazy.group[i.name].toscreen()),
            Key([mod], "Right", lazy.screen.next_group()),
            Key([mod], "Left", lazy.screen.prev_group()),
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name),
                lazy.group[i.name].toscreen(),
            ),
        }
    )


def init_widgets_defaults():
    return dict(
        font="FiraCode Nerd Font", fontsize=11, padding=3, background=colors[14]
    )


widget_defaults = init_widgets_defaults()

extension_defaults = widget_defaults.copy()


def open_pavu():
    qtile.cmd_spawn("pavucontrol")


def open_rofilauncher():
    qtile.cmd_spawn("./.config/rofi/scripts/applauncher.sh")


def open_powermenu():
    qtile.cmd_spawn("./.config/rofi/scripts/powermenu.sh")


prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())

# Widgets on the bar


def init_widgets_list():
    widgets_list = [
        widget.Sep(
            linewidth=1,
            padding=10,
            foreground=colors[13],
            background=colors[13],
        ),
        widget.Image(
            filename="~/.config/qtile/icons/archlabs.png",
            background=colors[13],
            margin_y=2,
            margin_x=7,
            mouse_callbacks={"Button1": open_rofilauncher},
        ),
        widget.TextBox(
            text="",
            fontsize=23,
            background=colors[13],
            foreground=colors[14],
            padding=0,
        ),
        widget.GroupBox(
            bg=colors[12],
            fg=colors[8],
            fontsize=14,
            borderwidth=3,
            padding_y=5,
            padding_x=6,
            active=colors[0],
            inactive=colors[1],
            rounded=True,
            highlight_color=colors[1],
            highlight_method="block",
            this_current_screen_border=colors[13],
            this_screen_border=colors[1],
            other_current_screen_border=colors[1],
            other_screen_border=colors[1],
        ),
        widget.TextBox(
            text="",
            fontsize=23,
            background=colors[14],
            foreground=colors[1],
            padding=0,
        ),
        widget.TextBox(
            text="",
            fontsize=23,
            background=colors[1],
            foreground=colors[12],
            padding=0,
        ),
        widget.TextBox(
            text="",
            fontsize=16,
            background=colors[12],
            foreground=colors[13],
            padding=0,
        ),
        widget.TextBox(
            text="",
            fontsize=16,
            background=colors[13],
            foreground=colors[13],
            padding=0,
        ),
        widget.Sep(
            linewidth=1,
            padding=3,
            foreground=colors[13],
            background=colors[13],
        ),
        widget.CurrentLayoutIcon(
            custom_icon_paths=[os.path.expanduser("~/.config/qtile/icons")],
            foreground=colors[0],
            background=colors[13],
            padding=5,
            scale=0.8,
        ),
        widget.TaskList(
            font="Hack Nerd Font",
            fontsize=13,
            padding=3,
            margin_x=5,
            margin_y=3,
            highlight_method="block",
            foreground=colors[0],
            border=colors[2],
            background=colors[13],
            max_title_width=200,
            icon_size=20,
        ),
        widget.Spacer(
            background=colors[13],
        ),
        widget.TextBox(
            text="",
            fontsize=23,
            background=colors[13],
            foreground=colors[12],
            padding=0,
        ),
        widget.TextBox(
            text="",
            fontsize=23,
            background=colors[12],
            foreground=colors[1],
            padding=0,
        ),
        widget.TextBox(
            text="",
            fontsize=23,
            background=colors[1],
            foreground=colors[12],
            padding=0,
        ),
        widget.TextBox(
            text="",
            fontsize=23,
            background=colors[12],
            foreground=colors[13],
            padding=0,
        ),
        widget.TextBox(
            text="  ",
            font="icomoon-feather bold",
            fontsize=12,
            background=colors[13],
            foreground=colors[10],
            padding=0,
        ),
        widget.Memory(
            font="Hack Nerd Font Bold",
            fontsize=11.5,
            background=colors[13],
            foreground=colors[1],
            format="{MemUsed: .0f} MB ",
            padding_y=4,
        ),
        widget.TextBox(
            text="",
            fontsize=20,
            background=colors[13],
            foreground=colors[12],
            padding=0,
        ),
        widget.TextBox(
            text="",
            fontsize=20,
            background=colors[12],
            foreground=colors[13],
            padding=0,
        ),
        #        widget.TextBox(
        #            text="   ",
        #            font="icomoon-feather bold",
        #            fontsize=12,
        #            foreground=colors[10],
        #            background=colors[13],
        #            padding=0
        #        ),
        # CPU Widget is not working due to a psutil issue
        #        widget.CPU(
        #            font="Hack Nerd Font Bold",
        #            fontsize=11.5,
        #            foreground=colors[1],
        #            background=colors[13],
        #            padding_y=4,
        #        ),
        #        widget.Net(
        #            font="Hack Nerd Font Bold",
        #            fontsize=11.5,
        #            foreground=colors[1],
        #            background=colors[13],
        #            padding_y=4,
        #            interface="wlo1",
        #            format = 'Net:{down}↓↑{up}',
        #        ),
        #        widget.Sep(
        #            linewidth=1,
        #            padding=7,
        #            foreground=colors[13],
        #            background=colors[13],
        #        ),
        #        widget.TextBox(
        #            text="",
        #            fontsize=16,
        #            background=colors[13],
        #            foreground=colors[2],
        #            padding=0
        #        ),
        #        widget.TextBox(
        #            text="",
        #            fontsize=16,
        #            background=colors[2],
        #            foreground=colors[13],
        #            padding=0
        #        ),
        widget.Sep(
            linewidth=1,
            padding=7,
            foreground=colors[13],
            background=colors[13],
        ),
        widget.Battery(
            format="{percent:2.0%}",
            update_interval=60,
            show_short_text=False,
            background=colors[13],
        ),
        widget.Systray(
            background=colors[13],
            padding=3,
            margin=4,
        ),
        widget.TextBox(
            text="",
            fontsize=12,
            background=colors[13],
            foreground=colors[13],
            padding=0,
        ),
        widget.TextBox(
            text="",
            fontsize=23,
            background=colors[13],
            foreground=colors[12],
            padding=0,
        ),
        widget.TextBox(
            text=today.strftime(" %A, %B %d, %Y "),
            font="Hack Nerd Font",
            fontsize=12.5,
            background=colors[12],
            foreground=colors[0],
            padding=4,
        ),
        widget.TextBox(
            text="",
            fontsize=23,
            background=colors[12],
            foreground=colors[1],
            padding=0,
        ),
        widget.TextBox(
            text="",
            fontsize=23,
            background=colors[1],
            foreground=colors[12],
            padding=0,
        ),
        widget.TextBox(
            text="  ",
            font="icomoon-feather bold",
            fontsize=11.5,
            background=colors[12],
            foreground=colors[10],
        ),
        widget.Clock(
            font="Hack Nerd Font",
            fontsize=12.5,
            background=colors[12],
            foreground=colors[0],
            padding=4,
        ),
        widget.TextBox(
            text="",
            fontsize=12,
            background=colors[12],
            foreground=colors[12],
            padding=0,
        ),
        widget.TextBox(
            text="",
            fontsize=23,
            background=colors[12],
            foreground=colors[13],
            padding=0,
        ),
        widget.TextBox(
            text="⏻ ",
            foreground=colors[10],
            background=colors[13],
            fontsize=13,
            padding=10,
            mouse_callbacks={"Button1": open_powermenu},
        ),
    ]
    return widgets_list


def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    return widgets_screen1

def init_screens():
    return [
        Screen(top=bar.Bar(widgets=init_widgets_screen1(), size=26, opacity=1)),
    ]

screens = init_screens()

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List

main = None


@hook.subscribe.startup_once
def start_once():
    subprocess.call([home + "/.config/qtile/autostart.sh"])


@hook.subscribe.startup
def start_always():
    # Set the cursor to something sane in X
    subprocess.Popen(["xsetroot", "-cursor_name", "left_ptr"])


@hook.subscribe.client_new
def set_floating(window):
    if (
        window.window.get_wm_transient_for()
        or window.window.get_wm_type() in floating_types
    ):
        window.floating = True


floating_types = ["notification", "toolbar", "splash", "dialog"]
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout =layout.Floating(**layout_theme,
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),
        Match(wm_class="dialog"),
        Match(wm_class="download"),
        Match(wm_class='steam'),
        Match(wm_class="error"),  # GPG key password entry
    ] 
)

auto_fullscreen = True
focus_on_window_activation = "smart"

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True
# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
