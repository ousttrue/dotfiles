[[TerminalEmulator]] [[Rust]]

https://wiki.archlinux.org/title/Alacritty
https://yukimemi.netlify.app/use-alacritty/

```yml
 #shell:
 #  program: /Windows/System32/wsl.exe ~ -d Ubuntu-20.04
 
 window:
   # Window dimensions (changes require restart)
   #
   # Specified in number of columns/lines, not pixels.
   # If both are `0`, this setting is ignored.
   dimensions:
     columns: 120
     lines: 50
 
 font:
   normal:
     family: Cica
     #style: regular
   size: 14
  
 # Colors (Hyper)
 colors:
   # Default colors
   primary:
     background: '0x000000'
     foreground: '0xffffff'
   cursor:
     text: '0xF81CE5'
     cursor: '0xffffff'
  
   # Normal colors
   normal:
     black:   '0x000000'
     red:     '0xfe0100'
     green:   '0x33ff00'
     yellow:  '0xfeff00'
     blue:    '0x0066ff'
     magenta: '0xcc00ff'
     cyan:    '0x00ffff'
     white:   '0xd0d0d0'
  
   # Bright colors
   bright:
     black:   '0x808080'
     red:     '0xfe0100'
     green:   '0x33ff00'
     yellow:  '0xfeff00'
     blue:    '0x0066ff'
     magenta: '0xcc00ff'
     cyan:    '0x00ffff'
     white:   '0xFFFFFF'
  
 background_opacity: 0.8
  
 mouse:
   double_click: { threshold: 300 }
   triple_click: { threshold: 300 }
   hide_when_typing: false
 
 mouse_bindings:
   - { mouse: Right, action: Copy }
   - { mouse: Middle, action: Paste }
   
  shell:
      program: "C:/Program Files/PowerShell/7/pwsh.exe"
