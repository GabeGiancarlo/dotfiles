--[[
================================================================================
  Core Configuration Module
================================================================================
  This module loads all core configuration components in the proper order.
  Core modules are loaded before plugins to ensure proper initialization.
================================================================================
--]]

-- Load core modules in order
require 'core.options' -- Editor options and settings
require 'core.keymaps' -- Key mappings
require 'core.autocmds' -- Autocommands
require 'core.diagnostics' -- Diagnostic configuration

-- vim: ts=2 sts=2 sw=2 et

