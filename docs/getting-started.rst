Getting started
===============

.. include:: includes/all.rst

.. contents::
   :local:


Example inventory
-----------------

Add the hosts on which should shutdown if the build-in battery is low to the
``ypid_shutdown_if_battery_low`` Ansible inventory group:

.. code:: ini

   [ypid_shutdown_if_battery_low]
   hostname

Example playbook
----------------

Here's an example playbook that uses the ypid.shutdown_if_battery_low_ role:

.. literalinclude:: playbooks/shutdown_if_battery_low.yml
   :language: yaml

The playbooks is shipped with this role under
:file:`docs/playbooks/shutdown_if_battery_low.yml` from which you can symlink it to your
playbook directory.
In case you use multiple roles maintained by ypid_, consider
using the `ypid-ansible-common`_.

Ansible tags
------------

You can use Ansible ``--tags`` or ``--skip-tags`` parameters to limit what
tasks are performed during Ansible run. This can be used after a host was first
configured to speed up playbook execution, when you are sure that most of the
configuration is already in the desired state.

Available role tags:

``role::shutdown_if_battery_low``
  Main role tag, should be used in the playbook to execute all of the role
  tasks as well as role dependencies.
