package require textSearch

textSearch::enableSearch textWidget ?flags?
 -noisearch  : Do not add incremental search 
 -nosearch   : Do not add search
 -label      : A variable to use as status for incremental search.

textSearch::searchMenu menuWidget
 Adds three entries to a menu widget.
 "Find...", "Find Next" and "Find Previous".
 The menu should be part of the same toplevel as a text widget
 with search enabled.

Incremental search
 To start an incremental search you press Ctrl-s.
 The search will start from the insertion cursor in the text widget.
 The status label is set to "i" to indicate incremental search.
 You end incremental search by pressing Esc or Ctrl-g.  Also any
 non-ascii key (such as F1) will end the search.
 Typing any sequence will search and highlight that sequence.
 Pressing Ctrl-s during incremental search will jump to the next
 match of the current string.
 Backspace and Delete goes backwards.

Search
 Ctrl-f will bring up a search dialog.
 F3 will repeat previous search.
 Shift-F3 will repeat previous search but backwards.
