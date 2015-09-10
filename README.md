# Simple Git Commit Parser

Currently checks:

* Each line is 72 characters max
* Summary has some sort of (alphaNum)-(digit) at the start, denoting, say, a
  Jira ticket.
* If the commit is multiline, ensures that there's a blank line between summary
  and body.
