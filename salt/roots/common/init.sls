# Create user dotfiles
{% for f in pillar['common']['dotfiles_user'] %}
{{ f.src }}:
  file.symlink:
    - target: {{ f.dest }}
    - force: True
    - makedirs: True
    - user: {{ pillar['defaults']['user'] }}
    - group: {{ pillar['defaults']['user'] }}
{% endfor %}

# Create user directories
{% for d in pillar['common']['dirs_to_create_user'] %}
{{ d }}:
  file.directory:
    - user: {{ pillar['defaults']['user'] }}
    - group: {{ pillar['defaults']['user'] }}
    - mode: 0755
    - makedirs: True
{% endfor %}

# Create root directories
{% for d in pillar['common']['dirs_to_create_root'] %}
{{ d }}:
  file.directory:
    - user: root
    - group: root
    - mode: 0755
    - makedirs: True
{% endfor %}
