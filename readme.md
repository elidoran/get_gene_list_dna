
# Meteor implementation of the NCBI sample tool

User submits search terms which are then provided as a list in their view.
The server *will* process the search terms and store their results.
Their view *will* update when the results are available.

Right now, it only accepts the search terms, stores them in the DB, displays
them to the user, and allows archiving them (the little x).

### Archiving

It does an archive instead of delete, for now, to maintain when search was done.

It prevents them from submitting the same search term again, but, will probably 
allow the search term to be resubmitted in the future, especially if the previous
search was archived.
