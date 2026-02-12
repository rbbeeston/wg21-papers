# WG21 Paper Style Rules

Rules for all work on WG21 papers in this repository.

## Formatting

1. ASCII only - no Unicode characters
2. Single dashes (`-`) for all dashes - no em-dashes, no double dashes
3. Human-written tone - not wordy, no AI-characteristic phrasing
4. No git operations - user handles all git manually
5. 80-character line wrapping where possible (tables excepted)
6. Padded tables with aligned pipe characters in every table on every rewrite
7. WG21-appropriate style
8. `[P####R#](https://wg21.link/p####r#)` link convention for all paper references
9. Paper titles on first mention
10. Backticks for code identifiers in headings
11. `\<` escaped angle brackets in front matter emails

## Language and Grammar

12. American English unless otherwise specified
13. Follow the Chicago Manual of Style unless otherwise specified
14. Use the Oxford comma
15. Avoid dangling "This" - every sentence beginning with "This" must
    have a clear, unambiguous antecedent. If "This" could refer to
    more than one thing, replace it with a specific noun phrase
16. Do not end sentences with a preposition in formal papers -
    e.g. "worth building upon" not "worth building on"
17. "bound" = attached/tied to; "bounded" = limited -
    e.g. "an allocator bound to that tenant's quota"
18. Possessive before a gerund -
    e.g. "coroutines' interacting" not "coroutines interacting"
19. "may" = permitted/possible; "might" = hypothetical/enabled but
    not currently supported. Use precisely
20. Prefer "deeper" or "more thorough" over "full" for appendix
    cross-references. Understatement is better than hyperbole
21. Headings must not contain a dangling "This" - replace with a
    specific noun phrase. e.g. "ABI Lock-In Makes the Architectural
    Gap Permanent" not "ABI Lock-In Makes This Permanent"
22. Transitive verbs must not leave their object implicit when the
    referent is not immediately obvious. Supply the object explicitly.
    e.g. "forgetting to forward the allocator" not "forgetting to
    forward"
23. Avoid ambiguous prepositional attachment. When a prepositional
    phrase could modify either a nearby noun or the main verb,
    restructure to make the attachment clear.
    e.g. "The allocator - along with its state - must be
    discoverable" not "The allocator - with its state - must be
    discoverable" (where "with its state" could attach to
    "discoverable")
24. Place "only" immediately before the word, phrase, or clause it
    modifies to avoid ambiguity.
    e.g. "provides only one mechanism" not "only provides one
    mechanism"
25. Do not use contractions (it's, they're, don't, etc.) in formal
    papers. Use the expanded form

## Code Examples

26. Consistent comment style within a code block - either all
    comments are sentences (capitalized, with terminating punctuation)
    or all are fragments (lowercase, no period). Do not mix
27. Consistent capitalization in groups of code comments that
    summarize arithmetic or data
28. Align trailing comment columns when consecutive lines have
    trailing comments

## Structure

29. Sections with subsections should have at least one introductory
    sentence between the section heading and the first subsection
    heading - do not leave an empty section heading

## Tone

30. Do not present options as predetermined conclusions. When
    recommending alternatives to a committee, present them as options
    to contemplate, not dictated outcomes
31. Avoid politically charged comparisons - do not invoke other
    contentious features as analogies unless the comparison is
    structurally precise. If the structures being compared are
    fundamentally different, the analogy will be perceived as
    political
