{ config, ... }:
{
 home.file.".config/rofi/theme.rasi" = {
      text = ''
      * {
    /* AMOLED liquid glass (dark), Telegram-ish accent */
    accent:            #2AABEE;
    foreground:        #E9EEF5;
    foreground-muted:  #A8B3C2;
    border-color:      #FFFFFF1A;

    background-color:  @background;
    /* semi-transparent background for "glass" look */
    background:        #000000CC;

    active-background: #0D141DB3;
    active-foreground: @foreground;
    normal-background: transparent;
    normal-foreground: @foreground;
    urgent-background: #FF3B30B3;
    urgent-foreground: @foreground;

    alternate-active-background: transparent;
    alternate-active-foreground: @foreground;
    alternate-normal-background: transparent;
    alternate-normal-foreground: @foreground;
    alternate-urgent-background: transparent;
    alternate-urgent-foreground: @foreground;

    selected-active-background: @urgent-background;
    selected-active-foreground: @foreground;
    selected-normal-background: @active-background;
    selected-normal-foreground: @foreground;
    selected-urgent-background: #FF9500B3;
    selected-urgent-foreground: @foreground;
    spacing: 2;
}

#window {
    background-color: @background;
    border: 2px;
    border-radius: 14px;
    padding: 2.5ch;
}

#mainbox {
    border: 0;
    padding: 0;
}

#message {
    border: 2px 0px 0px;
    border-color: @border-color;
    padding: 1px;
}

#textbox {
    text-color: @foreground;
}

#inputbar {
    children:   [ prompt,textbox-prompt-colon,entry,case-indicator ];
}

#textbox-prompt-colon {
    expand: false;
    str: ":";
    margin: 0px 0.3em 0em 0em;
    text-color: @normal-foreground;
}

#listview {
    fixed-height: 0;
    background-color: transparent;
    border: 2px 0px 0px;
    border-color: @border-color;
    spacing: 2px;
    scrollbar: true;
    padding: 2px 0px 0px;
}

#element {
    border: 0;
    padding: 1px;
    background-color: transparent;
}

#element-text, element-icon {
    background-color: inherit;
    text-color:       inherit;
}

#element.normal.normal {
    background-color: transparent;
    text-color: @normal-foreground;
}

#element.normal.urgent {
    background-color: transparent;
    text-color: @urgent-foreground;
}

#element.normal.active {
    background-color: transparent;
    text-color: @active-foreground;
}

#element.selected.normal {
    background-color: transparent;
    text-color: @selected-normal-foreground;
}

#element.selected.urgent {
    background-color: transparent;
    text-color: @selected-urgent-foreground;
}

#element.selected.active {
    background-color: transparent;
    text-color: @selected-active-foreground;
}

#element.alternate.normal {
    background-color: transparent;
    text-color: @alternate-normal-foreground;
}

#element.alternate.urgent {
    background-color: transparent;
    text-color: @alternate-urgent-foreground;
}

#element.alternate.active {
    background-color: transparent;
    text-color: @alternate-active-foreground;
}

#scrollbar {
    width: 4px;
    border: 0;
    handle-width: 8px;
    padding: 0;
}

#sidebar {
    border: 2px 0px 0px;
    border-color: @border-color;
}

#button {
    text-color: @normal-foreground;
}

#button.selected {
    background-color: @selected-normal-background;
    text-color: @selected-normal-foreground;
}

#inputbar {
    spacing: 0;
    text-color: @normal-foreground;
    padding: 1px;
}

#case-indicator {
    spacing: 0;
    text-color: @normal-foreground;
}

#entry {
    spacing: 0;
    text-color: @normal-foreground;
}

#prompt {
    spacing: 0;
    text-color: @normal-foreground;
}
      '';
 };
}
