# import urwid_windows_patch
import urwid.raw_display
import win_screen
urwid.raw_display.Screen = win_screen.Screen

print("### SCREEN ###")
