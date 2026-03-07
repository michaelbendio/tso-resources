AI Agent Rules for TSO Resources

Primary file: tso.html

Editing Rules
	•	Modify tso.html in-place.
	•	Avoid rewriting the entire file.
	•	Prefer minimal changes.

Protected Systems

Do not regress:
	•	services renderer
	•	tags system
	•	reviewedOn MM/YY format
	•	undo snapshot system
	•	favorites
	•	import/export JSON
	•	commit-on-leave persistence

Reliability

Safety harness must remain active.

Self tests should pass after changes.

Verify:
	•	create resource
	•	delete + undo
	•	tag assignment
	•	services preview/edit toggle
	•	export/import JSON
	•	show review dates sorting

Code Organization

Sections in tso.html must remain organized using banners.

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

Subsystem Boundaries

Some features are implemented as subsystems inside tso.html.
When modifying those features, change only the subsystem rather than scattering logic across the file.

Current subsystems include:

PrintWorkflow

Example guideline:

Changes to guided printing, print queues, packet printing, or print UI should occur inside PrintWorkflow.

Avoid introducing print logic directly into rendering or event-handler sections.

Print Workflow Rules

Printing uses a guided packet workflow implemented by the PrintWorkflow subsystem.

Key principles:
	•	The print queue is data-driven.
	•	Queue items contain:
	•	a label
	•	a render function.

Typical queue structure:

[
{ label: “Favorites”, render: … },
{ label: “Job Search Apps”, render: … }
]

Avoid branching logic such as:

if (step.type === …)

Prefer queue-driven rendering:

const step = queue[currentIndex]
step.render()

Architecture Records

Architecture decisions are documented in:

docs/architecture/

Agents must read relevant ADRs before modifying related subsystems.

Current ADRs:

ADR-001-print-workflow.md

Safe Change Discipline

To reduce accidental regressions in tso.html, follow this procedure when editing code:
	1.	Locate and quote the exact code block being modified (10–20 lines of context).
	2.	Explain the intended change briefly.
	3.	Produce a minimal unified diff patch rather than rewriting sections.
	4.	Do not move or reorganize large blocks unless explicitly instructed.
	5.	Preserve existing function names, IDs, and DOM structure unless required for the task.

This discipline ensures that AI edits remain small, auditable, and safe.

