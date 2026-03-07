Status: Accepted

Context

TSO Resources prints referral sheets for missionaries to give to clients.

Early implementations attempted to separate list resources from normal resources using CSS page breaks inside a single print job. This proved unreliable when printers were set to duplex (double-sided) printing, because a list resource could still begin on the back of a sheet.

The operational requirement is that resources tagged “This resource is a list” must always begin on the front of a new sheet so they can be handed out independently.

Browser printing cannot reliably enforce “start on the front of a sheet” within a single print job, especially across different browsers and printer drivers.

Decision

Printing uses a guided packet workflow rather than a single print job.

The workflow prints sections sequentially:
	1.	Normal favorites
	2.	Each favorited list resource separately

Each section is its own browser print job.

The workflow is implemented as a queue-driven guided session.

Example conceptual queue:

[
{ label: “Favorites”, render: renderFavorites },
{ label: “Scholarships for Single Parents”, render: renderList },
{ label: “Job Search Apps”, render: renderList }
]

The UI walks the user through the queue using modal navigation controls such as:

Print
Skip
Next

On the final step, the Next button is replaced by Close.

Consequences

Benefits:
	•	List resources always begin on the front of a sheet.
	•	Duplex printing becomes reliable.
	•	The workflow is deterministic and easy to understand.
	•	The queue model simplifies implementation.

Tradeoffs:
	•	Multiple browser print dialogs are required.
	•	The user must step through the print queue.

This tradeoff is acceptable because the workflow is guided and predictable.

Implementation Notes

The workflow is implemented inside a subsystem object named:

PrintWorkflow

Responsibilities of this subsystem include:
	•	building the print queue
	•	rendering the current step
	•	advancing to the next step
	•	skipping steps
	•	closing the print session
	•	updating progress indicators

The queue is data-driven. Each queue item contains its own label and rendering function.

Future changes to printing behavior should be implemented inside the PrintWorkflow subsystem rather than spread across unrelated parts of the application.

Future Extensions

Possible future enhancements include:
	•	packet templates
	•	category-based packets
	•	export to PDF
	•	batch packet generation

The queue-driven design allows additional printable packet types to be added by inserting new queue items without changing the core workflow logic.
