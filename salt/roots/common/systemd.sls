{% for c in pillar['common']['systemd_cmd'] %}
{{ c }}:
  cmd.run
{% endfor %}

# Configure autologin on getty@tty1.service
autologin_tmpl:
  file.managed:
    - name: /etc/systemd/system/getty@tty1.service.d/autologin.conf
    - source: salt://common/templates/autologin.conf.jinja
    - template: jinja
    - makedirs: True

getty_svc:
  service.running:
    - name: getty@tty1.service
    - enable: True
    - watch:
      - file: autologin_tmpl

bluetooth_svc:
  service.running:
    - name: bluetooth.service
    - enable: True
