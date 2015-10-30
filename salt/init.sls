'ruby2.2':
  pkg.installed

'ruby2.2-dev':
  pkg.installed

'libxslt-dev':
  pkg.installed

'libxslt1.1':
  pkg.installed

'postgresql-client':
  pkg.installed

'libpq-dev':
  pkg.installed

'set//default_gem_version':
  alternatives.set:
    - name: gem
    - path: /usr/bin/gem2.2

'set//default_ruby_version':
  alternatives.set:
    - name: ruby
    - path: /usr/bin/ruby2.2

'nginx-ppa':
  pkgrepo.managed:
    - ppa: nginx/stable

'nginx-doc':
  pkg.installed:
    - refresh: True

'nginx-extras':
  pkg.installed:
    - refresh: True

'install//ohmycron':
  cmd.run:
    - cwd: {{ salt['environ.get']('PWD') }}/..
    - name: |
        git clone git@github.com:instacart/ohmycron.git &&
        cp -a ohmycron/ohmycron /usr/local/bin/ohmycron

bundler:
  gem:
    - installed
    - ruby: 2.2
    - gem_bin: /usr/bin/gem2.2

'bundle install --binstubs vendor/bundle/bin -j4 --without development:test':
  cmd.run:
    - cwd: {{ salt['environ.get']('PWD') }}/..
    - require:
      - gem: bundler

eye:
  gem:
    - installed
    - ruby: 2.2
    - gem_bin: /usr/bin/gem2.2

/etc/init/eye.conf:
  file.managed:
    - source: salt://eye.upstart

nginx:
  service.running:
    - watch:
      - file: /etc/nginx/nginx.conf
    - reload: True
    - require:
      - pkg: nginx-extras

/etc/nginx/nginx.conf:
  file.managed:
    - source: salt://nginx.conf
    - template: jinja
    - require:
      - pkg: nginx-extras
