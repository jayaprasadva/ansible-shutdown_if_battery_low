Changelog
=========

.. include:: includes/all.rst

**ypid.shutdown_if_battery_low**

This project adheres to `Semantic Versioning <http://semver.org/spec/v2.0.0.html>`__
and `human-readable changelog <http://keepachangelog.com/en/0.3.0/>`__.

The current role maintainer_ is ypid_.


`ypid.shutdown_if_battery_low master`_ - unreleased
---------------------------------------------------

.. _ypid.shutdown_if_battery_low master: https://github.com/ypid/ansible-shutdown_if_battery_low/compare/v0.1.0...master


ypid.shutdown_if_battery_low v0.1.0 - 2015-11-10
------------------------------------------------

Added
~~~~~

- Initial coding and design. [ypid_]

Changed
~~~~~~~

- Changed namespace from ``shutdown_if_battery_low_`` to ``shutdown_if_battery_low__``.
  ``shutdown_if_battery_low_[^_]`` variables are hereby deprecated and you might need to
  update your inventory. This oneliner might come in handy to do this.

  .. code-block:: shell

     git ls-files -z | xargs --null -I '{}' find '{}' -type f -print0 | xargs --null sed --in-place --regexp-extended 's/\<(shutdown_if_battery_low)_([^_])/\1__\2/g;'

  [ypid_]
