TSO Resources Code Map

Primary file
tso.html

This application is intentionally implemented as a single HTML file with structured sections.
Agents should modify only the relevant section and avoid reorganizing the file.

SECTION OVERVIEW

STATE
Application state variables including resources, favorites, filters, and UI state.

UTILITIES
General helper functions used across the app.

DATA NORMALIZATION
Functions that sanitize or normalize resource data during import or editing.

PERSISTENCE
LocalStorage interaction, JSON import/export, and commit-on-leave persistence.

UNDO SYSTEM
Snapshot and restore logic for undo operations.

SAFETY HARNESS
Guards that prevent data corruption or invalid operations.

SELF TESTS
Built-in tests used to verify core functionality after changes.

RENDERING — GENERAL
Shared rendering helpers used by category and resource views.

RENDERING — CATEGORIES
Code responsible for rendering category lists and category navigation.

RENDERING — RESOURCES
Code responsible for rendering individual resource cards.

ADMIN MODE
Admin editing UI including resource editing and category editing.

EVENT HANDLERS
UI event wiring and button actions.

SUBSYSTEMS

PrintWorkflow
Handles the guided printing workflow.

Responsibilities include:
- building the print queue
- rendering the current print step
- handling Next / Skip / Print / Close actions
- updating progress indicators
- rendering favorites or list resources for printing

ARCHITECTURE REFERENCES

See docs/architecture/ADR-001-print-workflow.md for the design of the printing system.

AGENT GUIDELINES

When modifying code:

1. Locate the correct section using this map.
2. Modify only that section.
3. Do not reorganize unrelated sections.
4. Preserve banner structure in tso.html.

