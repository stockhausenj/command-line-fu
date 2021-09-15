# Ansible 
## Always do things like this
Lint that mint.
```
$ ansible-lint
```

Debugger the bugs.
```
- hosts: all
  debugger: on_failed
```

## Galaxy commands
```
$ ansible-galaxy install <owner>.<role_name> --force
$ ansible-galaxy list
$ ansible-galaxy login -vvv
$ ansible-galaxy init <role_name>
$ ansible-galaxy install -r requirements.yml
```

## All other things
Change SSH port.
```
$ ansible-playbook main.yaml -e ansible_ssh_port=6718
```

Get facts gathered from Windows server.
```
$ ansible windows -i inventory.yaml -m setup --extra-vars="ansible_port=5986 ansible_connection=winrm ansible_winrm_server_cert_validation=ignore" -u jay --ask-pass
```

Step through playbook.
```
$ansible-playbook main.yaml --step
```

Print debug info.
```
- name: dump all
  hosts: all
  tasks:
    - name: Print some debug information
      vars:
        msg: |
          Module Variables ("vars"):
          --------------------------------
          {{ vars | to_nice_json }}
          ================================

          Environment Variables ("environment"):
          --------------------------------
          {{ environment | to_nice_json }}
          ================================

          Group Variables ("groups"):
          --------------------------------
          {{ groups | to_nice_json }}
          ================================

          Host Variables ("hostvars"):
          --------------------------------
          {{ hostvars | to_nice_json }}
          ================================
      debug:
        msg: "{{ msg.split('\n') }}"
      tags: debug_info
```

Lint away.
```

```