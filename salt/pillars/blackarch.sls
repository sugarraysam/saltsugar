{% set home = grains['sugar']['home'] %}

blackarch:
  install_script_url: "https://blackarch.org/strap.sh"
  install_script_sha: "95b485d400f5f289f7613fe576f4a3996aabed62"
  pkgs:
    - aircrack-ng # Graphing tool for the aircrack suite
    - binwalk # A tool for searching a given binary image for embedded files
    - burpsuite # An integrated platform for attacking web applications (free edition)
    - dnsrecon # Python script for enumeration of hosts, subdomains and emails from a given domain using google
    - exploitdb # Offensive Security’s Exploit Database Archive
    - gef # Multi-Architecture GDB Enhanced Features for Exploiters & Reverse-Engineers
    - gobuster # Directory/file & DNS busting tool written in Go
    - metasploit # Advanced open-source platform for developing, testing, and using exploit code
    - radare2 # Open-source tools to disasm, debug, analyze and manipulate binary files
    - rkhunter # Checks machines for the presence of rootkits and other unwanted tools
    - sqlmap # Automatic SQL injection and database takeover tool
    - steghide # Embeds a message in a file by replacing some of the least significant bits
    - sublist3r # A Fast subdomains enumeration tool for penetration testers
    - yay # Yet another yogurt. Pacman wrapper and AUR helper written in go
  dotfiles:
    - {
        src: /srv/salt/blackarch/dotfiles/gdbinit,
        dest: {{ home }}/.gdbinit,
      }
    - {
        src: /srv/salt/blackarch/dotfiles/blackarch.sh,
        dest: {{ grains['sugar']['zshrcd_path'] }}/blackarch.sh,
      }
  git_repos:
    - {
        name: payloadallthethings,
        url: "https://github.com/swisskyrepo/PayloadsAllTheThings.git",
        dest: {{ home }}/opt/blackarch/PayloadsAllTheThings,
      }
    - {
        name: seclists,
        url: "https://github.com/danielmiessler/SecLists.git",
        dest: {{ home }}/opt/blackarch/SecLists,
      }
