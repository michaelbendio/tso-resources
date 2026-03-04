# AI Agent Rules for TSO Resources

Primary file: tso.html

## Editing Rules

- Modify tso.html in-place.
- Avoid rewriting the entire file.
- Prefer minimal changes.

## Protected Systems

Do not regress:

- services renderer
- tags system
- reviewedOn MM/YY format
- undo snapshot system
- favorites
- import/export JSON
- commit-on-leave persistence

## Reliability

Safety harness must remain active.

Self tests should pass after changes.

Verify:

- create resource
- delete + undo
- tag assignment
- services preview/edit toggle
- export/import JSON
- show review dates sorting

## Code Organization

Sections:

STATE  
UTILITIES  
DATA NORMALIZATION  
PERSISTENCE  
UNDO SYSTEM  
SAFETY HARNESS  
SELF TESTS  
RENDERING — GENERAL  
RENDERING — CATEGORIES  
RENDERING — RESOURCES  
ADMIN MODE  
EVENT HANDLERS

Do not remove these banners.
